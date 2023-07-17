import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/creators/creator.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class FieldsClassCreator extends Creator {
  static final _jsonSerializableType = TypeChecker.fromRuntime(JsonSerializable);

  final Config config;

  FieldsClassCreator({
    required this.config,
    required super.classSpec,
    required super.fieldSpecs,
  });

  late final List<FieldSpec> _paramsSpecs = fieldSpecs.where((e) => e.isParam).toList();

  @override
  bool get available => classSpec.createFieldsClass && _paramsSpecs.isNotEmpty;

  @override
  Iterable<Class> createLibraryClasses() sync* {
    yield createLibraryClassFields();
  }

  String _createFieldPath(FieldSpec fieldSpec, bool hasFieldMap) {
    return hasFieldMap ? '\$_path\${_get(\'${fieldSpec.name}\')}' : '\${_path}${fieldSpec.name}';
  }

  Method? _createMethodField(FieldSpec fieldSpec, String fieldPath) {
    final fieldClassElement = fieldSpec.element.type.element;
    if (fieldClassElement is! ClassElement) return null;

    final fieldClassReader = dataClassAnnotation(fieldClassElement);
    if (fieldClassReader == null) return null;

    final fieldClassSpec = ClassSpec.from(config, fieldClassElement, fieldClassReader);
    if (!fieldClassSpec.createFieldsClass) return null;

    final keysClassName =
        '${fieldClassSpec.fieldsClassVisible ? '' : '_'}${fieldClassElement.name}Fields';

    return Method((b) => b
      ..returns = Reference(keysClassName)
      ..type = MethodType.getter
      ..name = fieldSpec.name
      ..lambda = true
      ..body = Code("$keysClassName('$fieldPath.')"));
  }

  Class createLibraryClassFields() {
    final jsonSerializable = _jsonSerializableType.firstAnnotationOf(classSpec.element);
    final hasFieldMap = ConstantReader(jsonSerializable).peek('createFieldMap')?.boolValue ?? false;

    final className = '${classSpec.fieldsClassVisible ? '' : '_'}${classSpec.element.name}Fields';

    final methodsFields = _paramsSpecs.map((field) {
      final fieldPath = _createFieldPath(field, hasFieldMap);

      final result = _createMethodField(field, fieldPath);
      if (result != null) return result;

      return Method((b) => b
        ..returns = Refs.string
        ..type = MethodType.getter
        ..name = field.name
        ..lambda = true
        ..body = Code("'$fieldPath'"));
    });

    return Class((b) => b
      ..name = className
      ..fields.add(Field((b) => b
        ..modifier = FieldModifier.final$
        ..type = Refs.string
        ..name = '_path'))
      ..constructors.add(Constructor((b) => b
        ..docs.returnIf(!classSpec.fieldsClassVisible)?.add('// ignore: unused_element')
        ..constant = true
        ..optionalParameters.add(Parameter((b) => b
          ..toThis = true
          ..name = '_path'
          ..defaultTo = Code("''")))))
      ..methods.addAll(methodsFields)
      ..methods.add(Method((b) => b
        ..annotations.add(Annotations.override)
        ..returns = Refs.string
        ..name = 'toString'
        ..lambda = true
        ..body = Code("_path.isEmpty ? '$className()' : _path")))
      ..methods.returnIf(hasFieldMap)?.add(Method((b) => b
        ..returns = Refs.string
        ..name = '_get'
        ..requiredParameters.add(Parameter((b) => b
          ..type = Refs.string
          ..name = 'key'))
        ..lambda = true
        ..body = Code('_\$${classSpec.self.name}FieldMap[key]!'))));
  }
}
