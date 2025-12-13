import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/helpers/helper_core.dart';
import 'package:source_helper/source_helper.dart';

mixin MergeHelper on HelperCore {
  @override
  void register() {
    super.register();

    if (!config.mergeable) return;

    final parameters = this.parameters.where((e) => parameterConfigOf(e).updatable);
    if (!element.isAbstract) registerMixinSelfGetter();

    registerMixinMethod(_createCopyWithMethod(parameters));
  }

  Method _createCopyWithMethod(Iterable<FormalParameterElement> parameters) {
    Code? body;
    if (!element.isAbstract) {
      if (parameters.isEmpty) {
        body = const Code('_self');
      } else {
        body = lazyCode(() {
          final buffer = StringBuffer('if (other == null) return _self;');
          buffer.write('return ');
          writeNewInstance(buffer, (parameter) {
            if (parameterConfigOf(parameter).updatable) {
              buffer.write('other.');
              buffer.write(parameterConfigOf(parameter).accessor);
              if (parameter.type.isNullableType) {
                buffer.write(' ?? _self.');
                buffer.write(parameterConfigOf(parameter).accessor);
              }
            } else {
              buffer.write('_self.');
              buffer.write(parameterConfigOf(parameter).accessor);
            }
          });
          buffer.write(';');
          return Code(buffer.toString());
        });
      }
    }
    return Method(
      (b) => b
        ..returns = Reference(element.thisType.getDisplayString())
        ..name = 'merge'
        ..requiredParameters.add(
          Parameter(
            (b) => b
              ..covariant = true
              ..type = TypeReference(
                (b) => b
                  ..isNullable = true
                  ..symbol = element.thisType.getDisplayString(),
              )
              ..name = 'other',
          ),
        )
        ..lambda = body is StaticCode
        ..body = body,
    );
  }
}
