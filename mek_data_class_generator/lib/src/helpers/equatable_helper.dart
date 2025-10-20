import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:mek_data_class_generator/src/helpers/helper_core.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

mixin EquatableHelper on HelperCore {
  static const _equalityChecker = TypeChecker.typeNamed(Equality, inPackage: 'collection');

  @override
  void register() {
    super.register();

    if (!config.comparable || element.isAbstract) return;

    final fields = this.fields.where((e) => fieldConfigOf(e).equatable);
    if (fields.isNotEmpty) registerMixinSelfGetter();

    registerMixinMethod(_createEquals(fields));
    registerMixinMethod(_createHashCode(fields));
  }

  Method _createEquals(Iterable<FieldElement2> fields) {
    return Method(
      (b) => b
        ..annotations.add(const CodeExpression(Code('override')))
        ..returns = const Reference('bool')
        ..name = 'operator=='
        ..requiredParameters.add(
          Parameter(
            (b) => b
              ..type = const Reference('Object')
              ..name = 'other',
          ),
        )
        ..lambda = true
        ..body = lazyCode(() {
          final body = StringBuffer('identical(this, other) || other is ');
          body.write(element.thisType.getDisplayString());
          body.write(' && runtimeType == other.runtimeType ');
          body.writeAll(fields.map(_codeFieldEquals));
          return Code('$body');
        }),
    );
  }

  Method _createHashCode(Iterable<FieldElement2> fields) {
    return Method(
      (b) => b
        ..annotations.add(const CodeExpression(Code('override')))
        ..returns = const Reference('int')
        ..type = MethodType.getter
        ..name = 'hashCode'
        ..body = lazyCode(() {
          const hashVar = 'hashCode';
          final body = StringBuffer('${fields.isEmpty ? 'final' : 'var'} $hashVar = 0;\n');
          body.writeAll(
            fields.map((field) {
              return '$hashVar = \$hashCombine($hashVar, ${_codeEqualityHashcode(field)});';
            }),
          );
          body.write('return \$hashFinish($hashVar);');
          return Code('$body');
        }),
    );
  }

  String _codeFieldEquals(FieldElement2 field) {
    final equality = _codeEquality(field);
    if (equality != null) {
      return ' && $equality.equals(_self.${field.displayName}, other.${field.displayName})';
    }

    return ' && _self.${field.displayName} == other.${field.displayName}';
  }

  String _codeEqualityHashcode(FieldElement2 field) {
    final equality = _codeEquality(field);
    if (equality != null) return '$equality.hash(_self.${field.displayName})';

    return '_self.${field.displayName}.hashCode\n';
  }

  // COMMON

  String? _codeEquality(FieldElement2 field) {
    if (fieldConfigOf(field).equality case final equality?) return 'const ${equality.type!}()';

    final type = field.type;
    final externalEquality = _codeEqualityClasses(type);
    if (externalEquality != null) return 'const $externalEquality';

    if (type.isDartCoreMap) {
      return r'$mapEquality';
    } else if (type.isDartCoreSet) {
      return r'$setEquality';
    } else if (type.isDartCoreList) {
      return r'$listEquality';
    }
    return null;
  }

  String? _codeEqualityClasses(DartType type) {
    for (final equality in config.equalities) {
      final extendedEqualityClassElement = equality.type!.element3! as ClassElement2;
      final equalityClassElement = extendedEqualityClassElement.allSupertypes.singleWhereOrNull((
        e,
      ) {
        return _equalityChecker.isExactly(e.element3);
      });
      if (equalityClassElement == null) continue;

      final equalityType = equalityClassElement.typeArguments[0];
      if (type.isAssignableTo(equalityType)) {
        return '${extendedEqualityClassElement.thisType}()';
      }
      if (type.promoteNonNullable().isAssignableTo(equalityType)) {
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
}
