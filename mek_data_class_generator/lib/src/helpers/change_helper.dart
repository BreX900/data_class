import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/class_elements.dart';
import 'package:mek_data_class_generator/src/helpers/helper_core.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_helper/source_helper.dart';

mixin ChangeHelper on HelperCore {
  static const _classNameSuffix = 'Changes';
  TypeReference get _classReference => classReferenceFrom(element.thisType, _classNameSuffix);

  @override
  void register() {
    super.register();

    if (!config.changeable) return;

    if (!element.isAbstract) registerMixinSelfGetter();
    registerMixinMethod(_createChangeMethod());
    registerMixinMethod(_createToChangesMethod());

    final parameters = this.parameters.where((e) => parameterConfigOf(e).updatable);
    registerClass(_createChangesClass(parameters));
  }

  Method _createToChangesMethod() {
    Code? body;
    if (!element.isAbstract) {
      body = Code('${_classReference.symbol}._(_self)');
    }

    return Method(
      (b) => b
        ..returns = _classReference
        ..name = 'toChanges'
        ..lambda = body != null
        ..body = body,
    );
  }

  Method _createChangeMethod() {
    Code? body;
    if (!element.isAbstract) {
      body = const Code('(toChanges()..update(updates)).build()');
    }
    return Method(
      (b) => b
        ..returns = Reference(element.thisType.getDisplayString())
        ..name = 'change'
        ..requiredParameters.add(
          Parameter(
            (b) => b
              ..type = Reference('void Function(${_classReference.getDisplayString()} c)')
              ..name = 'updates',
          ),
        )
        ..lambda = body != null
        ..body = body,
    );
  }

  Class _createChangesClass(Iterable<FormalParameterElement> parameters) {
    TypedClassElements? superElements;
    if (this.superElements case final elements?) {
      if (elements.config.changeable) superElements = elements;
    }

    final originalField = Field(
      (b) => b
        ..annotations.addAll([if (superElements != null) Annotations.override])
        ..modifier = FieldModifier.final$
        ..type = Reference(element.thisType.getDisplayString())
        ..name = '_original',
    );
    final fields = parameters.map((parameter) {
      TypeReference? type;
      if (elementsOf(parameter) case final data? when data.config.changeable) {
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
          ..late = true
          ..type = type ?? Reference(parameter.type.getAliasOrDisplayString())
          ..name = parameter.displayName
          ..assignment = lazyCode(() {
            final code = '${originalField.name}.${parameterConfigOf(parameter).accessor}';
            if (type == null) return Code(code);
            return Code((type.isNullable ?? false) ? '$code?.toChanges()' : '$code.toChanges()');
          }),
      );
    });

    final constructor = Constructor(
      (b) => b
        ..name = '_'
        ..requiredParameters.add(
          Parameter(
            (b) => b
              ..toThis = true
              ..name = originalField.name,
          ),
        ),
    );

    final methodUpdate = Method(
      (b) => b
        ..annotations.addAll([if (superElements != null) Annotations.override])
        ..returns = const Reference('void')
        ..name = 'update'
        ..requiredParameters.add(
          Parameter(
            (b) => b
              ..type = Reference('void Function(${_classReference.getDisplayString()} c)')
              ..name = 'updates',
          ),
        )
        ..lambda = !element.isAbstract
        ..body = !element.isAbstract ? const Code('updates(this)') : null,
    );

    Code? methodBuildCode;
    if (!element.isAbstract) {
      methodBuildCode = lazyCode(() {
        if (parameters.isEmpty) return Code(originalField.name);

        final buffer = StringBuffer('return ');
        writeNewInstance(buffer, (parameter) {
          if (!parameterConfigOf(parameter).updatable) {
            buffer.write(originalField.name);
            buffer.write('.');
            buffer.write(parameterConfigOf(parameter).accessor);
          } else if (elementsOf(parameter)?.config.changeable ?? false) {
            buffer.write(parameter.displayName);
            if (parameter.type.isNullableType) buffer.write('?');
            buffer.write('.build()');
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
        ..lambda = parameters.isEmpty
        ..body = methodBuildCode,
    );

    return Class(
      (b) => b
        ..abstract = element.isAbstract
        ..name = _classReference.symbol
        ..types.addAll(element.typeParameters.map((e) => Reference(e.displayString())))
        ..implements.addAll([
          if (superElements?.type case final type?) classReferenceFrom(type, _classNameSuffix),
        ])
        ..fields.add(originalField)
        ..fields.addAll(fields)
        ..constructors.add(constructor)
        ..methods.add(methodUpdate)
        ..methods.add(methodBuild),
    );
  }
}
