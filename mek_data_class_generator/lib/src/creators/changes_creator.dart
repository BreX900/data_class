import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/creators/creator.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class ChangesCreator extends Creator {
  final Config config;

  ChangesCreator({
    required this.config,
    required ClassSpec classSpec,
    required List<FieldSpec> fieldSpecs,
  }) : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  late final List<FieldSpec> _paramsSpecs = fieldSpecs.where((e) => e.isParam).toList();

  @override
  bool get available => classSpec.changeable && _paramsSpecs.isNotEmpty;

  @override
  bool get needMixinMethodSelf => !classSpec.element.isAbstract;

  @override
  Iterable<Method> creteMixinMethods() sync* {
    yield _createMixinMethodChange();
    yield _createMixinMethodToChanges();
  }

  Method _createMixinMethodChange() {
    Code? body;
    if (!classSpec.element.isAbstract) {
      body = Code('(${classSpec.changes.typedName}._(_self)..update(updates)).build()');
    }

    return Method((b) => b
      ..returns = Reference(classSpec.self.typedName)
      ..name = 'change'
      ..requiredParameters.add(Parameter((b) => b
        ..type = Reference('void Function(${classSpec.changes.typedName} c)')
        ..name = 'updates'))
      ..lambda = body != null
      ..body = body);
  }

  Method _createMixinMethodToChanges() {
    Code? body;
    if (!classSpec.element.isAbstract) {
      body = Code('${classSpec.changes.name}._(_self)');
    }

    return Method((b) => b
      ..returns = Reference(classSpec.changes.typedName)
      ..name = 'toChanges'
      ..lambda = body != null
      ..body = body);
  }

  @override
  Iterable<Class> createLibraryClasses() sync* {
    yield createLibraryClassChanges();
  }

  Class createLibraryClassChanges() {
    final superType = findSuperDataClass(classSpec.element);
    var superFieldsName = const <String>[];
    String? implement;
    if (superType != null) {
      final superElement = superType.element2 as ClassElement;
      final superSpec = ClassSpec.from(
        config,
        superElement,
        ConstantReader(dataClassChecker.firstAnnotationOf(superType.element2)),
      );

      final superTypes = ClassSpec.t(superType.typeArguments.join(', '));
      final superName = '${visibility(superSpec.changesVisible)}${superType.element2.name}Changes';
      implement = '$superName$superTypes';
      superFieldsName = superElement.fields.where(isDataClassField).map((e) => e.name).toList();
    }

    final isAbstract = classSpec.element.isAbstract;
    final hasNeedDataClass = _paramsSpecs.any((e) => !e.updatable);
    final dataClassVarName = hasNeedDataClass ? '_dc' : 'dc';

    final fields = _paramsSpecs.where((field) => field.updatable).map((field) {
      return Field((b) => b
        ..returnIf(superFieldsName.contains(field.name))?.annotations.add(Annotations.override)
        ..type = Reference(field.getType(Nullability.inherit))
        ..name = field.name);
    });

    final constructorInitializers = _paramsSpecs.where((field) => field.updatable).map((field) {
      return '${field.name} = $dataClassVarName.${field.name}';
    });
    final constructor = Constructor((b) => b
      ..name = '_'
      ..requiredParameters.add(Parameter((b) => b
        ..toThis = hasNeedDataClass
        ..type = hasNeedDataClass ? null : Reference(classSpec.self.typedName)
        ..name = dataClassVarName))
      ..initializers.addAll(constructorInitializers.map(Code.new)));

    final methodUpdate = Method((b) => b
      ..returnIf(implement != null)?.annotations.add(Annotations.override)
      ..returns = Refs.void$
      ..name = 'update'
      ..requiredParameters.add(Parameter((b) => b
        ..type = Reference('void Function(${classSpec.changes.typedName} c)')
        ..name = 'updates'))
      ..lambda = !isAbstract
      ..returnIf(!isAbstract)?.body = Code('updates(this)'));

    Code? methodBuildCode;
    if (!isAbstract) {
      final params = _paramsSpecs.map((field) {
        return MapEntry(field.name, '${field.updatable ? '' : '$dataClassVarName.'}${field.name}');
      });
      methodBuildCode = Code(classSpec.instance(Map.fromEntries(params)));
    }
    final methodBuild = Method((b) => b
      ..returnIf(implement != null)?.annotations.add(Annotations.override)
      ..returns = Reference(classSpec.self.typedName)
      ..name = 'build'
      ..lambda = methodBuildCode != null
      ..body = methodBuildCode);

    return Class((b) => b
      ..abstract = isAbstract
      ..name = classSpec.changes.name
      ..types.addAll(classSpec.selfTypes.map(Reference.new))
      ..returnIf(implement != null)?.implements.add(Reference(implement))
      ..returnIf(hasNeedDataClass)?.fields.add(Field((b) => b
        ..modifier = FieldModifier.final$
        ..type = Reference(classSpec.self.typedName)
        ..name = '_dc'))
      ..fields.addAll(fields)
      ..constructors.add(constructor)
      ..methods.add(methodUpdate)
      ..methods.add(methodBuild));
  }
}
