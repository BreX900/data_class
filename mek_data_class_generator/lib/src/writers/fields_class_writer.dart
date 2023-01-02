import 'package:analyzer/dart/element/element.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';
import 'package:source_gen/source_gen.dart';

class FieldsClassWriter extends Writer {
  static final _jsonSerializableType = TypeChecker.fromRuntime(JsonSerializable);

  final Config config;

  FieldsClassWriter({
    required this.config,
    required ClassSpec classSpec,
    required List<FieldSpec> fieldSpecs,
  }) : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  late final List<FieldSpec> _paramsSpecs = fieldSpecs.where((e) => e.isParam).toList();

  @override
  bool get available => classSpec.createFieldsClass && _paramsSpecs.isNotEmpty;

  String buildFieldPath(FieldSpec fieldSpec, bool hasFieldMap) {
    return hasFieldMap ? '\$_path\${_get(\'${fieldSpec.name}\')}' : '\${_path}${fieldSpec.name}';
  }

  String? buildDataField(FieldSpec fieldSpec, String fieldPath) {
    final fieldClassElement = fieldSpec.element.type.element2;
    if (fieldClassElement is! ClassElement) return null;

    final fieldClassReader = dataClassAnnotation(fieldClassElement);
    if (fieldClassReader == null) return null;

    final fieldClassSpec = ClassSpec.from(config, fieldClassElement, fieldClassReader);
    if (!fieldClassSpec.createFieldsClass) return null;

    final keysClassName = '${fieldClassElement.name}Fields';
    return '$keysClassName get ${fieldSpec.name} => $keysClassName(\'$fieldPath.\');';
  }

  String buildField(FieldSpec fieldSpec, bool hasFieldMap) {
    final fieldPath = buildFieldPath(fieldSpec, hasFieldMap);

    final result = buildDataField(fieldSpec, fieldPath);

    return result ?? 'String get ${fieldSpec.name} => \'$fieldPath\';';
  }

  @override
  Iterable<String> writeClasses() sync* {
    final jsonSerializable = _jsonSerializableType.firstAnnotationOf(classSpec.element);
    final hasFieldMap = ConstantReader(jsonSerializable).peek('createFieldMap')?.boolValue ?? false;

    final className = '${classSpec.element.name}Fields';

    yield '''class $className {
    final String _path;

  const $className([this._path = '']);
  
  ${_paramsSpecs.map((e) => buildField(e, hasFieldMap)).join('\n')}    
  
  String toString() => _path.isEmpty ? '$className()' : _path;
''';
    if (hasFieldMap) {
      yield '''

  String _get(String key) => _\$${classSpec.self.name}FieldMap[key]!;
''';
    }
    yield '\n}';
  }
}
