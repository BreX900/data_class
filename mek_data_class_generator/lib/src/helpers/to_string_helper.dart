import 'package:analyzer/dart/element/element2.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/helpers/helper_core.dart';
import 'package:source_helper/source_helper.dart';

mixin ToStringHelper on HelperCore {
  @override
  void register() {
    super.register();

    if (!config.stringify) return;
    if (element.isAbstract) return;

    final fields = this.fields.where((e) => fieldConfigOf(e).stringify);
    if (fields.isNotEmpty) registerMixinSelfGetter();

    registerMixinMethod(_createToStringMixinMethod(fields));
  }

  Method _createToStringMixinMethod(Iterable<FieldElement2> fields) {
    return Method((b) => b
      ..annotations.add(const CodeExpression(Code('override')))
      ..returns = const Reference('String')
      ..name = 'toString'
      ..lambda = true
      ..body = lazyCode(() {
        final buffer = StringBuffer();

        if (fields.isNotEmpty) buffer.write('(');
        buffer.write('ClassToString(');
        buffer.write(escapeDartString(element.displayName));
        if (element.typeParameters2.isNotEmpty) {
          buffer.write(', [');
          buffer.writeAll(element.typeParameters2.map((e) => e.displayName), ', ');
          buffer.write(']');
        }
        buffer.write(')');
        if (fields.isNotEmpty) {
          for (final field in fields) {
            buffer.write('..');
            buffer.write(options.stringifyIfNull ? 'add(' : 'addIfExist(');
            buffer.write(escapeDartString(field.displayName));
            buffer.write(', ');
            final selfVarCode = '_self.${field.displayName}';
            if (fieldConfigOf(field).stringifier case final stringifier?) {
              buffer.write(stringifier);
              buffer.write('(');
              buffer.write(selfVarCode);
              buffer.write(')');
            } else {
              buffer.write(selfVarCode);
            }
            buffer.write(')');
          }
        }
        if (fields.isNotEmpty) buffer.write(')');
        buffer.write('.toString()');

        return Code(buffer.toString());
      }));
  }
}
