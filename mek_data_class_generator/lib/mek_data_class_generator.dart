import 'package:analyzer/dart/analysis/results.dart';
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
  Stream<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {
    try {
      await for (final result in _generateForAnnotatedElement(element, annotation, buildStep)) {
        yield result;
      }
    } catch (error, stackTrace) {
      // ignore: avoid_print, dead_code
      if (false) print('error\n$stackTrace');
      rethrow;
    }
  }

  Stream<String> _generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {
    if (element is! ClassElement) return;
    // Pick new valid library element: https://github.com/dart-lang/build/issues/2634#issuecomment-670603224
    final libraryElement = await buildStep.resolver.libraryFor(buildStep.inputId);
    final parsedLibrary =
        libraryElement.session.getParsedLibraryByElement(libraryElement) as ParsedLibraryResult;

    final constructorElement = element.unnamedConstructor ?? element.constructors.first;
    final fieldElements = createSortedFieldSet(element).where((field) {
      if (field.isStatic) return false;
      if (!field.isFinal) return false;
      return true;
    }).toList();

    final classSpec = ClassSpec.from(config, element, annotation);
    final fieldSpecs = fieldElements.map((element) {
      return FieldSpec.from(parsedLibrary, classSpec, element);
    }).toList();

    final missingFields = constructorElement.parameters.where((param) {
      return fieldSpecs.every((e) => e.isParam && e.element.name != param.name);
    }).toList();

    if (missingFields.isNotEmpty) {
      throw 'Missing constructor parameters declaration for ${missingFields.join(', ')}.';
    }

    final cb = StringBuffer();
    final lb = StringBuffer();

    for (final writer in _writeGenerators(classSpec, fieldSpecs)) {
      if (!writer.available) continue;

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
    yield EqualityWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    yield ToStringWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    yield CopyWithWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    yield ChangesWriter(config: config, classSpec: classSpec, fieldSpecs: fieldSpecs);
    yield FieldsClassWriter(config: config, classSpec: classSpec, fieldSpecs: fieldSpecs);
  }
}
