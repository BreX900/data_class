import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:mek_data_class_generator/src/creators/creator.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class EqualityCreator extends Creator {
  static final _equalityChecker = TypeChecker.fromRuntime(Equality);

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

  String? _codeEqualityClasses(DartType type) {
    for (final equality in classSpec.equalities) {
      final extendedEqualityClassElement = equality.type!.element as ClassElement;
      final equalityClassElement =
          extendedEqualityClassElement.allSupertypes.singleWhereOrNull((e) {
        return _equalityChecker.isExactly(e.element);
      });
      if (equalityClassElement == null) continue;

      final fieldType = equalityClassElement.typeArguments[0];
      if (fieldType == type) {
        return '${extendedEqualityClassElement.thisType}()';
      }
      if (fieldType == type.promoteNonNullable()) {
        return '\$NullableEquality(${extendedEqualityClassElement.thisType}())';
      }
    }

    if (type.isDartCoreMap) {
      final typeArguments = (type as InterfaceType).typeArguments;
      final keyEquality = _codeEqualityClasses(typeArguments[0]);
      final valueEquality = _codeEqualityClasses(typeArguments[1]);

      if (keyEquality != null && valueEquality != null) {
        return '\$CollectionEquality(\$MultiEquality([$keyEquality, $valueEquality))';
      } else if (keyEquality != null || valueEquality != null) {
        return '\$CollectionEquality(${keyEquality ?? valueEquality})';
      }
      return null;
    } else if (type.isDartCoreSet) {
      final elementType = (type as InterfaceType).typeArguments[0];
      final elementEquality = _codeEqualityClasses(elementType);
      if (elementEquality == null) return null;
      return '\$CollectionEquality($elementEquality)';
    } else if (type.isDartCoreList) {
      final elementType = (type as InterfaceType).typeArguments[0];
      final elementEquality = _codeEqualityClasses(elementType);
      if (elementEquality == null) return null;
      return '\$CollectionEquality($elementEquality)';
    }
    return null;
  }

  String? _codeEquality(FieldSpec field) {
    if (field.equality != null) return 'const ${field.equality!.type!}()';

    final type = field.element.type;
    final externalEquality = _codeEqualityClasses(type);
    if (externalEquality != null) return 'const $externalEquality';

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
    final equality = _codeEquality(field);
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
    final equality = _codeEquality(field);
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
