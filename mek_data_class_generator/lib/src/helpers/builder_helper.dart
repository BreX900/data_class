import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/class_elements.dart';
import 'package:mek_data_class_generator/src/helpers/helper_core.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_helper/source_helper.dart';

mixin BuilderHelper on HelperCore {
  static const _classNameSuffix = 'Builder';
  TypeReference get _classReference => classReferenceFrom(element.thisType, _classNameSuffix);

  @override
  void register() {
    super.register();

    if (!config.buildable) return;

    if (!element.isAbstract) registerMixinSelfGetter();
    registerMixinMethod(_createRebuildMixinMethod());
    registerMixinMethod(_createToBuilderMixinMethod());

    registerClass(_createBuilderClass());
  }

  Method _createToBuilderMixinMethod() {
    Code? body;
    if (!element.isAbstract) {
      body = Code('${_classReference.symbol}()..replace(_self)');
    }
    return Method(
      (b) => b
        ..returns = Reference(_classReference.getDisplayString())
        ..name = 'toBuilder'
        ..lambda = body != null
        ..body = body,
    );
  }

  Method _createRebuildMixinMethod() {
    Code? body;
    if (!element.isAbstract) {
      body = const Code('(toBuilder()..update(updates)).build()');
    }
    return Method(
      (b) => b
        ..returns = Reference(element.thisType.getDisplayString())
        ..name = 'rebuild'
        ..requiredParameters.add(
          Parameter(
            (b) => b
              ..type = Reference('void Function(${_classReference.getDisplayString()} b)')
              ..name = 'updates',
          ),
        )
        ..lambda = body != null
        ..body = body,
    );
  }

  Class _createBuilderClass() {
    TypedClassElements? superElements;
    if (this.superElements case final elements?) {
      if (elements.config.buildable) superElements = elements;
    }

    final fields = parameters.map((parameter) {
      TypeReference? type;
      if (elementsOf(parameter) case final data? when data.config.buildable) {
        type = classReferenceFrom(
          data.element.thisType,
          _classNameSuffix,
        ).rebuild((b) => b..isNullable = parameter.type.isNullableType);
      }
      return Field(
        (b) => b
          ..annotations.addAll([
            if (superElements case final elements?
                when elements.containsField(parameter.displayName))
              Annotations.override,
          ])
          ..type = type ?? Reference(parameter.type.getAliasOrDisplayString().nullable)
          ..name = parameter.displayName
          ..assignment = type != null && !(type.isNullable ?? false)
              ? Code('${type.getDisplayString()}()')
              : null,
      );
    });

    final methodUpdate = Method(
      (b) => b
        ..annotations.addAll([if (superElements != null) Annotations.override])
        ..returns = const Reference('void')
        ..name = 'update'
        ..requiredParameters.add(
          Parameter(
            (b) => b
              ..type = Reference('void Function(${_classReference.getDisplayString()} b)')
              ..name = 'updates',
          ),
        )
        ..lambda = !element.isAbstract
        ..body = element.isAbstract ? null : const Code('updates(this)'),
    );

    Code? methodBuildCode;
    if (!element.isAbstract) {
      methodBuildCode = lazyCode(() {
        final buffer = StringBuffer('return ');
        writeNewInstance(buffer, (parameter) {
          if (elementsOf(parameter)?.config.buildable ?? false) {
            buffer.write(parameter.displayName);
            if (parameter.type.isNullableType) buffer.write('?');
            buffer.write('.build()');
          } else if (!parameter.type.isNullableType) {
            buffer.write('ArgumentError.checkNotNull(');
            buffer.write(parameter.displayName);
            buffer.write(', ');
            buffer.write(escapeDartString(parameter.displayName));
            buffer.write(')');
          } else {
            buffer.write(parameter.displayName);
          }
        });
        buffer.write(';');
        return Code(buffer.toString());
      });
    }
    final methodBuild = Method(
      (b) => b
        ..annotations.addAll([if (superElements != null) Annotations.override])
        ..returns = Reference(element.thisType.getDisplayString())
        ..name = 'build'
        ..body = methodBuildCode,
    );

    Code? methodReplaceCode;
    if (!element.isAbstract) {
      methodReplaceCode = lazyCode(() {
        final buffer = StringBuffer();
        for (final parameter in parameters) {
          if (parameter.displayName == 'other') buffer.write('this.');
          buffer.write(parameter.displayName);
          buffer.write(' = other.');
          buffer.write(parameterConfigOf(parameter).accessor);
          if (elementsOf(parameter)?.config.buildable ?? false) {
            if (parameter.type.isNullableType) buffer.write('?');
            buffer.write('.toBuilder()');
          }
          buffer.write(';\n');
        }
        return Code(buffer.toString());
      });
    }
    final methodReplace = Method(
      (b) => b
        ..annotations.addAll([if (superElements != null) Annotations.override])
        ..returns = const Reference('void')
        ..name = 'replace'
        ..requiredParameters.add(
          Parameter(
            (b) => b
              ..type = Reference('covariant ${element.thisType.getDisplayString()}')
              ..name = 'other',
          ),
        )
        ..body = methodReplaceCode,
    );

    return Class(
      (b) => b
        ..abstract = element.isAbstract
        ..name = _classReference.symbol
        ..types.addAll(element.typeParameters2.map((e) => Reference(e.displayString2())))
        ..implements.addAll([
          if (superElements?.type case final type?) classReferenceFrom(type, _classNameSuffix),
        ])
        ..fields.addAll(fields)
        ..methods.add(methodUpdate)
        ..methods.add(methodBuild)
        ..methods.add(methodReplace),
    );
  }
}
