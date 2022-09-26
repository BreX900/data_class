import 'package:analyzer/dart/element/element.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';

class FieldsClassWriter extends Writer {
  final Config config;

  FieldsClassWriter({
    required this.config,
    required ClassSpec classSpec,
    required List<FieldSpec> fieldSpecs,
  }) : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  String? buildDataField(FieldSpec fieldSpec) {
    final fieldClassElement = fieldSpec.element.type.element2;
    if (fieldClassElement is! ClassElement) return null;

    final fieldClassReader = dataClassAnnotation(fieldClassElement);
    if (fieldClassReader == null) return null;

    final fieldClassSpec = ClassSpec.from(config, fieldClassElement, fieldClassReader);
    if (!fieldClassSpec.createFieldsClass) return null;

    final keysClassName = '${fieldClassElement.name}Fields';
    return '$keysClassName get ${fieldSpec.name} => $keysClassName(\'\${_path}${fieldSpec.name}.\');';
  }

  String buildField(FieldSpec fieldSpec) {
    final result = buildDataField(fieldSpec);

    return result ?? 'String get ${fieldSpec.name} => \'\${_path}${fieldSpec.name}\';';
  }

  @override
  Iterable<String> writeClasses() sync* {
    final className = '${classSpec.element.name}Fields';
    yield '''class $className {
    final String _path;

  const $className([this._path = '']);

  ${fieldSpecs.map(buildField).join('\n')}    
  
  String toString() => _path.isEmpty ? '$className()' : _path;
}''';
  }
}
