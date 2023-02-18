import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/creators/creator.dart';
import 'package:mek_data_class_generator/src/specs.dart';

class EqualityCreator extends Creator {
  EqualityCreator({
    required ClassSpec classSpec,
    required List<FieldSpec> fieldSpecs,
  }) : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  @override
  bool get available => classSpec.comparable;

  @override
  bool get needMixinMethodSelf => _fieldSpecs.isNotEmpty;

  late final _fieldSpecs = fieldSpecs.where((e) => e.isParam && e.comparable);

  @override
  Iterable<Method> creteMixinMethods() sync* {
    yield _createMixinMethodEqual();
    yield _createMixinMethodHashcode();
  }

  String? _codeEqualityVar(FieldSpec field) {
    if (field.equality != null) return field.equality;

    final type = field.element.type;
    if (type.isDartCoreMap) {
      return '\$mapEquality';
    } else if (type.isDartCoreSet) {
      return '\$setEquality';
    } else if (type.isDartCoreList) {
      return '\$listEquality';
    }
    return null;
  }

  String _codeFieldEquals(FieldSpec field) {
    final equality = _codeEqualityVar(field);
    if (equality != null) return ' && $equality.equals(_self.${field.name}, other.${field.name})';

    return ' && _self.${field.name} == other.${field.name}';
  }

  Method _createMixinMethodEqual() {
    final body = StringBuffer('identical(this, other) || other is ');
    body.write(classSpec.self.typedName);
    body.write(' && runtimeType == other.runtimeType ');
    body.writeAll(_fieldSpecs.map(_codeFieldEquals));

    return Method((b) => b
      ..annotations.add(Annotations.override)
      ..returns = Refs.bool
      ..name = 'operator=='
      ..requiredParameters.add(Parameter((b) => b
        ..type = Refs.object
        ..name = 'other'))
      ..lambda = true
      ..body = Code('$body'));
  }

  String _codeEqualityHashcode(FieldSpec field) {
    final equality = _codeEqualityVar(field);
    if (equality != null) return '$equality.hash(_self.${field.name})';

    return '_self.${field.name}.hashCode\n';
  }

  Method _createMixinMethodHashcode() {
    final hashVar = 'hashCode';

    final body = StringBuffer('var $hashVar = 0;\n');
    body.writeAll(_fieldSpecs.map((field) {
      return '$hashVar = \$hashCombine($hashVar, ${_codeEqualityHashcode(field)});';
    }));
    body.write('return \$hashFinish($hashVar);');

    return Method((b) => b
      ..annotations.add(Annotations.override)
      ..returns = Refs.int
      ..type = MethodType.getter
      ..name = 'hashCode'
      ..body = Code('$body'));
  }
}
