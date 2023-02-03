import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';

class EqualityWriter extends Writer {
  EqualityWriter({required ClassSpec classSpec, required List<FieldSpec> fieldSpecs})
      : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  @override
  bool get available => classSpec.comparable;

  @override
  bool get needMixinMethodSelf => _fieldSpecs.isNotEmpty;

  late final _fieldSpecs = fieldSpecs.where((e) => e.isParam && e.comparable);

  @override
  Iterable<Method> creteMixinMethods() sync* {
    yield _createMixinMethodProps();
    yield _createMixinMethodEqual();
    yield _createMixinMethodHashcode();
  }

  Method _createMixinMethodProps() {
    final props = _fieldSpecs.where((field) => field.equality == null).map((field) {
      return 'yield _self.${field.name};';
    });
    return Method((b) => b
      ..returns = Reference('Iterable<Object?>')
      ..type = MethodType.getter
      ..name = '_props'
      ..modifier = MethodModifier.syncStar
      ..body = Code(props.join()));
  }

  Iterable<String> _generateEquals() sync* {
    for (var field in _fieldSpecs) {
      if (field.equality == null) continue;

      yield '${field.equality}.equals(_self.${field.name}, other.${field.name})';
    }
  }

  Method _createMixinMethodEqual() {
    var equals = _generateEquals().join(' && ');
    if (equals.isNotEmpty) equals = ' && $equals';

    final body = Code('''identical(this, other) ||
      other is ${classSpec.self.typedName} &&
          runtimeType == other.runtimeType &&
          DataClass.\$equals(_props, other._props)$equals''');

    return Method((b) => b
      ..annotations.add(Annotations.override)
      ..returns = Refs.bool
      ..name = 'operator=='
      ..requiredParameters.add(Parameter((b) => b
        ..type = Refs.object
        ..name = 'other'))
      ..lambda = true
      ..body = body);
  }

  Iterable<String> _codeEqualityHashcode() sync* {
    for (var field in _fieldSpecs) {
      if (field.equality == null) continue;

      yield '${field.equality}.hash(_self.${field.name})';
    }
  }

  Method _createMixinMethodHashcode() {
    var propsStr = '_props';
    final equalityHascode = _codeEqualityHashcode().join(', ');
    if (equalityHascode.isNotEmpty) propsStr += '.followedBy([$equalityHascode])';

    return Method((b) => b
      ..annotations.add(Annotations.override)
      ..returns = Refs.int
      ..type = MethodType.getter
      ..name = 'hashCode'
      ..lambda = true
      ..body = Code('Object.hashAll($propsStr)'));
  }
}
