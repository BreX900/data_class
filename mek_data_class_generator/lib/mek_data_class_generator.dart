import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/field_helpers.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:mek_data_class_generator/src/writers/changes_writer.dart';
import 'package:mek_data_class_generator/src/writers/copy_with_writer.dart';
import 'package:mek_data_class_generator/src/writers/equality_writer.dart';
import 'package:mek_data_class_generator/src/writers/fields_class_writer.dart';
import 'package:mek_data_class_generator/src/writers/to_string_writer.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';
import 'package:source_gen/source_gen.dart';

class DataClassGenerator extends GeneratorForAnnotation<DataClass> {
  static final DartEmitter _dartEmitter = DartEmitter(useNullSafetySyntax: true);

  final Config config;

  DataClassGenerator({
    required this.config,
  });

  @override
  Future<String?> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) return null;
    // Pick new valid library element: https://github.com/dart-lang/build/issues/2634#issuecomment-670603224
    final libraryElement = await buildStep.resolver.libraryFor(buildStep.inputId);
    final parsedLibrary =
        libraryElement.session.getParsedLibraryByElement(libraryElement) as ParsedLibraryResult;

    final constructorElement = element.unnamedConstructor ?? element.constructors.first;
    final fieldElements = createSortedFieldSet(element).where(isDataClassField).toList();

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

    var needMixinMethodSelf = false;
    var mixinMethods = Iterable<Method>.empty();
    var libraryClasses = Iterable<Class>.empty();

    for (final writer in _writeGenerators(classSpec, fieldSpecs)) {
      if (!writer.available) continue;

      if (writer.needMixinMethodSelf) needMixinMethodSelf = true;
      mixinMethods = mixinMethods.followedBy(writer.creteMixinMethods());
      libraryClasses = libraryClasses.followedBy(writer.createLibraryClasses());
    }

    Method? mixinMethodSelf;
    if (needMixinMethodSelf) {
      mixinMethodSelf = Method((b) => b
        ..returns = Reference(classSpec.self.typedName)
        ..type = MethodType.getter
        ..name = '_self'
        ..lambda = true
        ..body = Code('this as ${classSpec.self.typedName}'));
    }
    final mixin = Mixin((b) => b
      ..name = classSpec.mixin.fullTypedName
      ..returnIf(mixinMethodSelf != null)?.methods.add(mixinMethodSelf!)
      ..methods.addAll(mixinMethods));

    final library = Library((b) => b
      ..body.add(mixin)
      ..body.addAll(libraryClasses));

    return '${library.accept(_dartEmitter)}';
  }

  Iterable<Writer> _writeGenerators(ClassSpec classSpec, List<FieldSpec> fieldSpecs) sync* {
    yield EqualityWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    yield ToStringWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    yield CopyWithWriter(classSpec: classSpec, fieldSpecs: fieldSpecs);
    yield ChangesWriter(config: config, classSpec: classSpec, fieldSpecs: fieldSpecs);
    yield FieldsClassWriter(config: config, classSpec: classSpec, fieldSpecs: fieldSpecs);
  }
}
