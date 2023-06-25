import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/specs.dart';

abstract class Creator {
  final ClassSpec classSpec;
  final List<FieldSpec> fieldSpecs;

  const Creator({required this.classSpec, required this.fieldSpecs});

  bool get available;
  bool get needMixinMethodSelf => false;

  Iterable<Method> creteMixinMethods() sync* {}

  Iterable<Spec> createLibraryClasses() sync* {}

  String visibility(bool isVisible) => isVisible ? '' : '_';
}

extension ReturnIf<T extends Object> on T {
  T? returnIf(bool condition) => condition ? this : null;
}

abstract class Refs {
  static Reference get void$ => const Reference('void');
  static Reference get object => const Reference('Object');
  static Reference get bool => const Reference('bool');
  static Reference get int => const Reference('int');
  static Reference get string => const Reference('String');
}

abstract class Annotations {
  static final Expression override = CodeExpression(Code('override'));
}
