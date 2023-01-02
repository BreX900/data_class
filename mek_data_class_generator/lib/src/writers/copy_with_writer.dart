import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';

class CopyWithWriter extends Writer {
  CopyWithWriter({required ClassSpec classSpec, required List<FieldSpec> fieldSpecs})
      : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  late final List<FieldSpec> _paramsSpecs = fieldSpecs.where((e) => e.isParam).toList();

  @override
  bool get available => classSpec.copyable && _paramsSpecs.isNotEmpty;

  @override
  Iterable<String> writeMethods() sync* {
    String writeBody() {
      return ''' {
    return ${classSpec.self.name}(
    ${_generateClassArgs().join()}    
    );
  }''';
    }

    yield '''
  ${classSpec.self.typedName} copyWith({
    ${_generateMethodArgs().join()}
  })${writeMethodBody(writeBody)}''';
  }

  Iterable<String> _generateMethodArgs() sync* {
    for (var field in _paramsSpecs) {
      if (!field.updatable) continue;

      yield '${withNull(field.getType(nullable: true))} ${field.name},\n';
    }
  }

  Iterable<String> _generateClassArgs() sync* {
    for (var field in _paramsSpecs) {
      yield '${field.name}: ${field.updatable ? '${field.name} ?? ' : ''}_self.${field.name},\n';
    }
  }
}
