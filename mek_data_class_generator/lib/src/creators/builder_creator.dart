import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/creators/creator.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class BuilderCreator extends Creator {
  final Config config;

  BuilderCreator({
    required this.config,
    required super.classSpec,
    required super.fieldSpecs,
  });

  late final List<FieldSpec> _paramsSpecs = fieldSpecs.where((e) => e.isParam).toList();

  @override
  bool get available => classSpec.buildable && _paramsSpecs.isNotEmpty;

  @override
  bool get needMixinMethodSelf => !classSpec.element.isAbstract;

  // TODO: Uncomment to support class editing via builder
  // @override
  // Iterable<Method> creteMixinMethods() sync* {
  //   yield _createMixinMethodChange();
  //   yield _createMixinMethodToChanges();
  // }
  //
  // Method _createMixinMethodChange() {
  //   Code? body;
  //   if (!classSpec.element.isAbstract) {
  //     body = Code('(${classSpec.builder.typedName}(updates)).build()');
  //   }
  //
  //   return Method((b) => b
  //     ..returns = Reference(classSpec.self.typedName)
  //     ..name = 'rebuild'
  //     ..requiredParameters.add(Parameter((b) => b
  //       ..type = Reference('void Function(${classSpec.builder.typedName} b)')
  //       ..name = 'updates'))
  //     ..lambda = body != null
  //     ..body = body);
  // }
  //
  // Method _createMixinMethodToChanges() {
  //   Code? body;
  //   if (!classSpec.element.isAbstract) {
  //     body = Code('${classSpec.builder.name}()..replace(_self)');
  //   }
  //
  //   return Method((b) => b
  //     ..returns = Reference(classSpec.builder.typedName)
  //     ..name = 'toBuilder'
  //     ..lambda = body != null
  //     ..body = body);
  // }

  @override
  Iterable<Spec> createLibraryClasses() sync* {
    // if (!classSpec.element.isAbstract) yield _createBuildFunction();
    yield createLibraryClassChanges();
  }
  // TODO: Uncomment to support class creation via a build function.
  // Method _createBuildFunction() {
  //   return Method((b) => b
  //     ..returns = Reference(classSpec.self.typedName)
  //     ..name = '_\$build${classSpec.self.name}'
  //     ..requiredParameters.add(Parameter((b) => b
  //       ..type = Reference('void Function(${classSpec.builder.typedName} b)')
  //       ..name = 'updates'))
  //     ..types.addAll(classSpec.self.fullTypes.map(Reference.new))
  //     ..lambda = true
  //     ..body = Code('(${classSpec.builder.typedName}()..update(updates)).build()'));
  // }

  Class createLibraryClassChanges() {
    final superType = findSuperDataClass(classSpec.element);
    var superFieldsName = const <String>[];
    String? implement;
    if (superType != null) {
      final superElement = superType.element as ClassElement;
      final superSpec = ClassSpec.from(
        config,
        superElement,
        ConstantReader(dataClassChecker.firstAnnotationOf(superType.element)),
      );

      if (superSpec.buildable) {
        final superTypes = ClassSpec.t(superType.typeArguments.map((e) => '$e'));
        final superName = '${superType.element.name}Builder';
        implement = '$superName$superTypes';
        superFieldsName = superElement.fields.where(isDataClassField).map((e) => e.name).toList();
      }
    }

    final isAbstract = classSpec.element.isAbstract;

    final fields = _paramsSpecs.map((field) {
      return Field((b) => b
        ..returnIf(superFieldsName.contains(field.name))?.annotations.add(Annotations.override)
        ..type = Reference(field.getType(Nullability.always))
        ..name = field.name);
    });

    final methodUpdate = Method((b) => b
      ..returnIf(implement != null)?.annotations.add(Annotations.override)
      ..returns = Refs.void$
      ..name = 'update'
      ..requiredParameters.add(Parameter((b) => b
        ..type = Reference('void Function(${classSpec.builder.typedName} b)')
        ..name = 'updates'))
      ..lambda = !isAbstract
      ..returnIf(!isAbstract)?.body = Code('updates(this)'));

    Code? methodBuildCode;
    if (!isAbstract) {
      final params = _paramsSpecs.map((field) {
        return MapEntry(field.name,
            '${field.name}${field.element.type.nullabilitySuffix == NullabilitySuffix.none ? '!' : ''}');
      });
      methodBuildCode = Code(classSpec.instance(Map.fromEntries(params)));
    }
    final methodBuild = Method((b) => b
      ..returnIf(implement != null)?.annotations.add(Annotations.override)
      ..returns = Reference(classSpec.self.typedName)
      ..name = 'build'
      ..lambda = methodBuildCode != null
      ..body = methodBuildCode);

    Code? methodReplaceCode;
    if (!isAbstract) {
      final params = _paramsSpecs.map((field) {
        return '${field.name == 'other' ? 'this.' : ''}${field.name} = other.${field.name};';
      });
      methodReplaceCode = Code(params.join('\n'));
    }
    final methodReplace = Method((b) => b
      ..returnIf(implement != null)?.annotations.add(Annotations.override)
      ..returns = Refs.void$
      ..name = 'replace'
      ..requiredParameters.add(Parameter((b) => b
        ..type = Reference('${implement != null ? 'covariant ' : ''}${classSpec.self.typedName}')
        ..name = 'other'))
      ..body = methodReplaceCode);

    return Class((b) => b
      ..abstract = isAbstract
      ..name = classSpec.builder.name
      ..types.addAll(classSpec.selfTypes.map(Reference.new))
      ..returnIf(implement != null)?.implements.add(Reference(implement))
      ..fields.addAll(fields)
      ..methods.add(methodUpdate)
      ..methods.add(methodBuild)
      ..methods.add(methodReplace));
  }
}
