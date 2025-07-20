import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:collection/collection.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class NameSpec {
  final String name;
  final List<String> types;
  final List<String> fullTypes;

  NameSpec({
    required this.name,
    required this.fullTypes,
    required this.types,
  });

  late final String fullJoinedTypes = ClassSpec.t(fullTypes);
  late final String fullTypedName = '$name$fullJoinedTypes';
  late final String typedName = '$name${ClassSpec.t(types)}';
}

class ClassSpec {
  final ClassElement2 element;
  final List<String> types;
  final bool comparable;
  final bool stringify;
  final StringifyType stringifyType;
  final bool stringifyIfNull;
  final bool buildable;
  final bool copyable;
  final bool changeable;
  final bool changesVisible;
  final bool createFieldsClass;
  final bool fieldsClassVisible;
  final List<DartObject> equalities;

  ClassSpec({
    required this.element,
    required this.types,
    required this.comparable,
    required this.buildable,
    required this.copyable,
    required this.stringify,
    required this.stringifyType,
    required this.stringifyIfNull,
    required this.changeable,
    required this.changesVisible,
    required this.createFieldsClass,
    required this.fieldsClassVisible,
    required this.equalities,
  });

  late final List<String> _fullJoinedTypes =
      element.typeParameters2.map((e) => e.displayString2()).toList();
  late final List<String> _types = element.typeParameters2.map((e) => e.displayName).toList();

  static String t(Iterable<String> t) => t.isEmpty ? '' : '<${t.join(', ')}>';

  late final NameSpec self = NameSpec(
    name: element.name3!,
    fullTypes: _fullJoinedTypes,
    types: _types,
  );

  late final NameSpec mixin = NameSpec(
    name: '_\$${element.name3!}',
    fullTypes: _fullJoinedTypes,
    types: _types,
  );

  late final NameSpec changes = NameSpec(
    name: '${changesVisible ? '' : '_'}${element.name3!}Changes',
    fullTypes: _fullJoinedTypes,
    types: _types,
  );

  late final NameSpec builder = NameSpec(
    name: '${element.name3!}Builder',
    fullTypes: _fullJoinedTypes,
    types: _types,
  );

  factory ClassSpec.from(Config config, ClassElement2 element, ConstantReader annotation) {
    return ClassSpec(
      element: element,
      types: element.typeParameters2.map((e) => e.displayName).toList(),
      comparable: annotation.peek('comparable')?.boolValue ?? config.comparable,
      stringify: annotation.peek('stringify')?.boolValue ?? config.stringify,
      stringifyType: config.stringifyType,
      stringifyIfNull: config.stringifyIfNull,
      buildable: annotation.peek('buildable')?.boolValue ?? config.buildable,
      copyable: annotation.peek('copyable')?.boolValue ?? config.copyable,
      changeable: annotation.peek('changeable')?.boolValue ?? config.changeable,
      changesVisible: annotation.peek('changesVisible')?.boolValue ?? config.changesVisible,
      createFieldsClass:
          annotation.peek('createFieldsClass')?.boolValue ?? config.createFieldsClass,
      fieldsClassVisible:
          annotation.peek('fieldsClassVisible')?.boolValue ?? config.fieldsClassVisible,
      equalities: annotation.peek('equalities')!.listValue,
    );
  }

  String instance(Map<String, String> params) {
    final constructor = element.defaultConstructor;
    final parameters = constructor.formalParameters.map((param) {
      return param.isNamed
          ? '${param.name3}: ${params[param.name3]!},'
          : '${params[param.name3]!},';
    });
    return '${self.name}(${parameters.join()})';
  }
}

enum Nullability { none, inherit, always }

class FieldSpec {
  final ConstructorElement2 _constructorElement;
  final FieldElement2 element;

  final String name;
  final bool comparable;
  final DartObject? equality;
  final bool stringify;
  final String? stringifier;
  final bool updatable;

  late final bool isParam = _isParam(_constructorElement, element);
  late final bool isParamNullable = _isParamNullable(_constructorElement, element);

  FieldSpec({
    required ConstructorElement2 constructorElement,
    required this.element,
    required this.name,
    required this.comparable,
    required this.equality,
    required this.stringify,
    required this.stringifier,
    required this.updatable,
  }) : _constructorElement = constructorElement;

  factory FieldSpec.from(
    ConstructorElement2 constructorElement,
    FieldElement2 element,
  ) {
    final annotation = dataFieldAnnotation(element);

    return FieldSpec(
      constructorElement: constructorElement,
      element: element,
      name: element.displayName,
      comparable: annotation.peek('comparable')?.boolValue ?? true,
      equality: annotation.peek('equality')?.objectValue,
      stringify: annotation.peek('stringify')?.boolValue ?? true,
      stringifier: annotation.peek('stringifier')?.revive().accessor,
      updatable: annotation.peek('updatable')?.boolValue ?? true,
    );
  }

  String getType(Nullability nullability) {
    final type = element.type.getDisplayString();

    switch (nullability) {
      case Nullability.none:
        return type.endsWith('?') ? type.substring(type.length - 1) : type;
      case Nullability.inherit:
        return type;
      case Nullability.always:
        return type.endsWith('?') ? type : '$type?';
    }
  }

  static bool _isParam(ConstructorElement2 constructorElement, FieldElement2 element) {
    if (element.isPrivate) return false;
    if (element.hasInitializer) return false;

    return constructorElement.formalParameters.any((e) => e.name3 == element.name3);
  }

  static bool _isParamNullable(ConstructorElement2 constructorElement, FieldElement2 element) {
    final param =
        constructorElement.formalParameters.firstWhereOrNull((e) => e.name3 == element.name3);
    if (param == null) return false;
    return param.type.isNullable;
  }
}
