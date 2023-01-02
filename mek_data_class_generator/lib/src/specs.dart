import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class NameSpec {
  final String name;
  final String fullJoinedTypes;
  final String joinedTypes;

  NameSpec({
    required this.name,
    required this.fullJoinedTypes,
    required this.joinedTypes,
  });

  late final String fullTypedName = '$name$fullJoinedTypes';
  late final String typedName = '$name$joinedTypes';
}

class ClassSpec {
  final ClassElement element;
  final List<String> types;
  final bool comparable;
  final bool stringify;
  final StringifyType stringifyType;
  final bool copyable;
  final bool changeable;
  final bool changesVisible;
  final bool createFieldsClass;

  ClassSpec({
    required this.element,
    required this.types,
    required this.comparable,
    required this.copyable,
    required this.stringify,
    required this.stringifyType,
    required this.changeable,
    required this.changesVisible,
    required this.createFieldsClass,
  });

  late final String _fullJoinedTypes =
      t(element.typeParameters.map((e) => e.getDisplayString(withNullability: true)).join(', '));
  late final String _joinedTypes = t(element.typeParameters.map((e) => e.displayName).join(', '));

  static String t(String t) => t.isEmpty ? '' : '<$t>';

  late final NameSpec self = NameSpec(
    name: element.name,
    fullJoinedTypes: _fullJoinedTypes,
    joinedTypes: _joinedTypes,
  );

  late final NameSpec mixin = NameSpec(
    name: '_\$${element.name}',
    fullJoinedTypes: _fullJoinedTypes,
    joinedTypes: _joinedTypes,
  );

  late final NameSpec changes = NameSpec(
    name: '${changesVisible ? '' : '_'}${element.name}Changes',
    fullJoinedTypes: _fullJoinedTypes,
    joinedTypes: _joinedTypes,
  );

  factory ClassSpec.from(Config config, ClassElement element, ConstantReader annotation) {
    return ClassSpec(
      element: element,
      types: element.typeParameters.map((e) => e.displayName).toList(),
      comparable: annotation.peek('comparable')?.boolValue ?? config.comparable,
      stringify: annotation.peek('stringify')?.boolValue ?? config.stringify,
      stringifyType: config.stringifyType,
      copyable: annotation.peek('copyable')?.boolValue ?? config.copyable,
      changeable: annotation.peek('changeable')?.boolValue ?? config.changeable,
      changesVisible: annotation.peek('changesVisible')?.boolValue ?? config.changesVisible,
      createFieldsClass:
          annotation.peek('createFieldsClass')?.boolValue ?? config.createFieldsClass,
    );
  }
}

class FieldSpec {
  final FieldElement element;

  final String name;
  final bool comparable;
  final bool stringify;
  final bool updatable;
  final String? stringifier;

  late final bool isParam = _isParam(element.enclosingElement3 as ClassElement, element);

  FieldSpec({
    required this.element,
    required this.name,
    required this.comparable,
    required this.stringify,
    required this.updatable,
    required this.stringifier,
  });

  factory FieldSpec.from(ClassSpec classSpec, FieldElement element) {
    final annotation = dataFieldAnnotation(element);

    return FieldSpec(
      element: element,
      name: element.displayName,
      comparable: annotation.peek('comparable')?.boolValue ?? true,
      stringify: annotation.peek('stringify')?.boolValue ?? true,
      updatable: annotation.peek('updatable')?.boolValue ?? true,
      stringifier: annotation.peek('stringifier')?.revive().accessor,
    );
  }

  String getType({required bool nullable}) => _getType(element.type, nullable: nullable);

  static String _getType(DartType type, {required bool nullable}) {
    final alias = type.alias;

    if (alias != null) {
      final args = alias.typeArguments.map((e) => _getType(e, nullable: true)).toList();
      final shouldNullable = nullable && type.nullabilitySuffix != NullabilitySuffix.none;
      return '${alias.element.displayName}${args.isEmpty ? '' : '<${args.join(', ')}>'}${shouldNullable ? '?' : ''}';
    }

    final name = type.getDisplayString(withNullability: true);
    final shouldNotNullable = !nullable && name.endsWith('?');
    return shouldNotNullable ? name.substring(0, name.length - 1) : name;
  }

  static bool _isParam(ClassElement classElement, FieldElement element) {
    if (element.isPrivate) return false;
    if (element.hasInitializer) return false;

    final constructorElement = classElement.unnamedConstructor ?? classElement.constructors.first;
    return constructorElement.parameters.any((e) => e.name == element.name);
  }
}
