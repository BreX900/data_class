import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/creators/creator.dart';
import 'package:mek_data_class_generator/src/specs.dart';

class CopyWithCreator extends Creator {
  CopyWithCreator({
    required super.classSpec,
    required super.fieldSpecs,
  });

  late final List<FieldSpec> _paramsSpecs = fieldSpecs.where((e) => e.isParam).toList();

  @override
  bool get available => classSpec.copyable && _paramsSpecs.isNotEmpty;

  @override
  bool get needMixinMethodSelf => true;

  @override
  Iterable<Method> creteMixinMethods() sync* {
    yield _createMixinMethodCopyWith();
  }

  Method _createMixinMethodCopyWith() {
    final params = _paramsSpecs.where((field) => field.updatable).map((field) {
      return Parameter((b) => b
        ..named = true
        ..type = Reference(field.getType(Nullability.always))
        ..name = field.name);
    });

    Code? body;
    if (!classSpec.element.isAbstract) {
      final params = _paramsSpecs.map((field) {
        return MapEntry(
          field.name,
          '${field.updatable ? '${field.name} ?? ' : ''}_self.${field.name}',
        );
      });
      body = Code('return ${classSpec.instance(Map.fromEntries(params))};');
    }

    return Method((b) => b
      ..returns = Reference(classSpec.self.typedName)
      ..name = 'copyWith'
      ..optionalParameters.addAll(params)
      ..body = body);
  }
}
