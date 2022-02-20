import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/field_helpers.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/writers/changes_writer.dart';
import 'package:mek_data_class_generator/src/writers/copy_with_writer.dart';
import 'package:mek_data_class_generator/src/writers/equality_writer.dart';
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
    if (element is! ClassElement) return;

    final classSpec = ClassSpec.from(config, element, annotation);
    final fieldSpecs = createSortedFieldSet(element).where((field) {
      if (field.isStatic || !field.isFinal) return false;
      if (field.isPrivate || field.hasInitializer) return false;
      return true;
    }).map((element) {
      return FieldSpec.from(classSpec, element);
    }).toList();

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

    yield '// ignore_for_file: annotate_overrides';
    yield '''mixin ${classSpec.mixin.fullTypedName} {
  ${classSpec.self.typedName} get _self => this as ${classSpec.self.typedName};
  
  ${cb.toString()}
}''';

    yield lb.toString();
  }

  Iterable<Writer> _writeGenerators(ClassSpec classSpec, List<FieldSpec> fieldSpecs) sync* {
    if (classSpec.comparable) yield EqualityWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    if (classSpec.stringify) yield ToStringWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    if (classSpec.copyable) yield CopyWithWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    if (classSpec.changeable) {
      yield ChangesWriter(config: config, classSpec: classSpec, fieldSpecs: fieldSpecs);
    }
  }
}
