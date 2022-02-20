import 'package:analyzer/dart/element/element.dart';
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
  final bool copyable;
  final bool changeable;
  final bool changesVisible;

  ClassSpec({
    required this.element,
    required this.types,
    required this.comparable,
    required this.copyable,
    required this.stringify,
    required this.changeable,
    required this.changesVisible,
  });

  late final String _fullJoinedTypes =
      t(element.typeParameters.map((e) => e.getDisplayString(withNullability: true)).join(', '));
  late final String _joinedTypes = t(element.typeParameters.map((e) => e.displayName).join(', '));

  static t(String t) => t.isEmpty ? '' : '<$t>';

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
      copyable: annotation.peek('copyable')?.boolValue ?? config.copyable,
      changeable: annotation.peek('changeable')?.boolValue ?? config.changeable,
      changesVisible: annotation.peek('changesVisible')?.boolValue ?? config.changesVisible,
    );
  }
}

class FieldSpec {
  final String name;
  final String type;
  final String originalType;
  final bool comparable;
  final bool stringify;
  final bool updatable;
  final String? stringifier;

  const FieldSpec({
    required this.name,
    required this.type,
    required this.originalType,
    required this.comparable,
    required this.stringify,
    required this.updatable,
    this.stringifier,
  });

  factory FieldSpec.from(ClassSpec classSpec, FieldElement element) {
    final annotation = dataFieldAnnotation(element);

    return FieldSpec(
      name: element.displayName,
      type: element.type.getDisplayString(withNullability: false),
      originalType: element.type.getDisplayString(withNullability: true),
      comparable: annotation.peek('comparable')?.boolValue ?? true,
      stringify: annotation.peek('stringify')?.boolValue ?? true,
      updatable: annotation.peek('updatable')?.boolValue ?? true,
      stringifier: annotation.peek('stringifier')?.revive().accessor,
    );
  }
}
