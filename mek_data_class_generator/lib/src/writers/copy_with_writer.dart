import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';

class CopyWithWriter extends Writer {
  const CopyWithWriter({required ClassSpec classSpec, required List<FieldSpec> fieldSpecs})
      : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  @override
  Iterable<String> writeMethods() sync* {
    String _writeBody() {
      return ''' {
    return ${classSpec.self.name}(
    ${_generateClassArgs().join()}    
    );
  }''';
    }

    yield '''
  ${classSpec.self.typedName} copyWith({
    ${_generateMethodArgs().join()}
  })${writeMethodBody(_writeBody)}''';
  }

  Iterable<String> _generateMethodArgs() sync* {
    for (var field in fieldSpecs) {
      yield '${withNull(field.originalType)} ${field.name},\n';
    }
  }

  Iterable<String> _generateClassArgs() sync* {
    for (var field in fieldSpecs) {
      yield '${field.name}: ${field.name} ?? _self.${field.name},\n';
    }
  }
}
