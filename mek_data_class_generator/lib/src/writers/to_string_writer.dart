import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';

class ToStringWriter extends Writer {
  const ToStringWriter({required ClassSpec classSpec, required List<FieldSpec> fieldSpecs})
      : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  @override
  Iterable<String> writeMethods() sync* {
    final types = classSpec.types.isEmpty ? '' : ', ${classSpec.types}';

    yield '''
  @override
  String toString() => (ClassToString('${classSpec.self.name}'$types)
      ${_writeFields().join('\n')}).toString();''';
  }

  Iterable<String> _writeFields() sync* {
    for (var spec in fieldSpecs) {
      if (!spec.stringify) continue;

      final variable = '_self.${spec.name}';
      final stringifier = spec.stringifier;
      final stringifyVariable = stringifier != null ? '$stringifier($variable)' : variable;
      yield '..add(\'${spec.name}\', $stringifyVariable)';
    }
  }
}
