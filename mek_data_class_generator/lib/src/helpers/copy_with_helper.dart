import 'package:analyzer/dart/element/element2.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/helpers/helper_core.dart';
import 'package:mek_data_class_generator/src/utils.dart';

mixin CopyWithHelper on HelperCore {
  @override
  void register() {
    super.register();

    if (!config.copyable) return;

    final parameters = this.parameters.where((e) => parameterConfigOf(e).updatable);
    if (!element.isAbstract && parameters.isNotEmpty) registerMixinSelfGetter();

    registerMixinMethod(_createCopyWithMethod(parameters));
  }

  Method _createCopyWithMethod(Iterable<FormalParameterElement> parameters) {
    Code? body;
    if (!element.isAbstract) {
      body = lazyCode(() {
        final buffer = StringBuffer('return ');
        writeNewInstance(buffer, (parameter) {
          if (parameterConfigOf(parameter).updatable) {
            buffer.write('Unspecified.resolve(_self.');
            buffer.write(parameterConfigOf(parameter).accessor);
            buffer.write(', ');
            buffer.write(parameter.displayName);
            buffer.write(')');
          } else {
            buffer.write('_self.');
            buffer.write(parameterConfigOf(parameter).accessor);
          }
        });
        buffer.write(';');
        return Code(buffer.toString());
      });
    }
    return Method(
      (b) => b
        ..returns = Reference(element.thisType.getDisplayString())
        ..name = 'copyWith'
        ..optionalParameters.addAll(
          parameters.map(
            (parameter) => Parameter(
              (b) => b
                ..named = true
                ..type = TypeReference(
                  (b) => b
                    ..symbol = r'$Parameter'
                    ..types.add(Reference(parameter.type.getAliasOrDisplayString())),
                )
                ..name = parameter.displayName
                ..defaultTo = const Code('const Unspecified()'),
            ),
          ),
        )
        ..body = body,
    );
  }
}
