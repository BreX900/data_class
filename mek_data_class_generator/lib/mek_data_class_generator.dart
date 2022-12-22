import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/field_helpers.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/writers/changes_writer.dart';
import 'package:mek_data_class_generator/src/writers/copy_with_writer.dart';
import 'package:mek_data_class_generator/src/writers/equality_writer.dart';
import 'package:mek_data_class_generator/src/writers/fields_class_writer.dart';
import 'package:mek_data_class_generator/src/writers/to_string_writer.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';
import 'package:source_gen/source_gen.dart';

class DataClassGenerator extends GeneratorForAnnotation<DataClass> {
  final Config config;

  DataClassGenerator({
    required this.config,
  });

  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    try {
      for (final result in _generateForAnnotatedElement(element, annotation, buildStep)) {
        yield result;
      }
    } catch (error, stackTrace) {
      // ignore: avoid_print, dead_code
      if (false) print('error\n$stackTrace');
      rethrow;
    }
  }

  Iterable<String> _generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    if (element is! ClassElement) return;
    final constructorElement = element.unnamedConstructor ?? element.constructors.first;
    final fieldsElements = createSortedFieldSet(element).where((field) {
      if (field.isStatic || !field.isFinal) return false;
      if (field.isPrivate || field.hasInitializer) return false;

      if (!constructorElement.parameters.any((e) => e.name == field.name)) return false;
      return true;
    });

    final classSpec = ClassSpec.from(config, element, annotation);
    final fieldSpecs = fieldsElements.map((element) => FieldSpec.from(classSpec, element)).toList();

    final missingFields = constructorElement.parameters.where((param) {
      return fieldsElements.every((e) => e.name != param.name);
    }).toList();

    if (missingFields.isNotEmpty) {
      throw 'Missing constructor parameters declaration for ${missingFields.join(', ')}.';
    }

    final cb = StringBuffer();
    final lb = StringBuffer();

    for (final writer in _writeGenerators(classSpec, fieldSpecs)) {
      for (final method in writer.writeMethods()) {
        cb.write('\n');
        cb.write('\n');
        cb.write(method);
      }
      for (final class$ in writer.writeClasses()) {
        lb.write('\n');
        lb.write(class$);
      }
    }

    yield '// ignore_for_file: annotate_overrides, unused_element';
    yield '''mixin ${classSpec.mixin.fullTypedName} {
  ${classSpec.self.typedName} get _self => this as ${classSpec.self.typedName};
  
  ${cb.toString()}
}''';

    yield lb.toString();
  }

  Iterable<Writer> _writeGenerators(ClassSpec classSpec, List<FieldSpec> fieldSpecs) sync* {
    final updatableFields = fieldSpecs.any((e) => e.updatable);

    if (classSpec.comparable) {
      yield EqualityWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    }
    if (classSpec.stringify) {
      yield ToStringWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    }
    if (classSpec.copyable && updatableFields) {
      yield CopyWithWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    }
    if (classSpec.changeable && updatableFields) {
      yield ChangesWriter(config: config, classSpec: classSpec, fieldSpecs: fieldSpecs);
    }
    if (classSpec.createFieldsClass) {
      yield FieldsClassWriter(config: config, classSpec: classSpec, fieldSpecs: fieldSpecs);
    }
  }
}
