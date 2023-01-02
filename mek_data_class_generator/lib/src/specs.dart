import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
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

enum Nullability { none, inherit, always }

class FieldSpec {
  final ParsedLibraryResult parsedLibrary;
  final FieldElement element;

  final String name;
  final bool comparable;
  final String? equality;
  final bool stringify;
  final String? stringifier;
  final bool updatable;

  late final bool isParam = _isParam(element.enclosingElement3 as ClassElement, element);

  FieldSpec({
    required this.parsedLibrary,
    required this.element,
    required this.name,
    required this.comparable,
    required this.equality,
    required this.stringify,
    required this.stringifier,
    required this.updatable,
  });

  factory FieldSpec.from(
    ParsedLibraryResult parsedLibrary,
    ClassSpec classSpec,
    FieldElement element,
  ) {
    final annotation = dataFieldAnnotation(element);

    final equality = annotation.peek('equality')?.revive().source.fragment;

    return FieldSpec(
      parsedLibrary: parsedLibrary,
      element: element,
      name: element.displayName,
      comparable: annotation.peek('comparable')?.boolValue ?? true,
      equality: equality != null ? 'const $equality()' : null,
      stringify: annotation.peek('stringify')?.boolValue ?? true,
      stringifier: annotation.peek('stringifier')?.revive().accessor,
      updatable: annotation.peek('updatable')?.boolValue ?? true,
    );
  }

  String getType(Nullability nullability) {
    final prefixedElements = element.library.libraryImports.expand<Element>((e) {
      if (e.prefix == null) return [];
      return e.namespace.definedNames.values;
    });

    final type = prefixedElements.contains(element.type.element2)
        ? _getTypeWithPrefix(parsedLibrary, element)
        : _getType(element.type);

    switch (nullability) {
      case Nullability.none:
        return type.endsWith('?') ? type.substring(type.length - 1) : type;
      case Nullability.inherit:
        return type;
      case Nullability.always:
        return type.endsWith('?') ? type : '$type?';
    }
  }

  static String _getType(DartType type) {
    final alias = type.alias;
    if (alias != null) {
      final args = alias.typeArguments.map(_getType).toList();
      final nullable = type.nullabilitySuffix != NullabilitySuffix.none;
      return '${alias.element.displayName}${args.isEmpty ? '' : '<${args.join(', ')}>'}${nullable ? '?' : ''}';
    }
    return type.getDisplayString(withNullability: true);
  }

  /// The [builderElementType] plus any import prefix.
  static String _getTypeWithPrefix(ParsedLibraryResult parsedLibrary, FieldElement element) {
    // final parsedLibrary = parsedLibraryResult(classSpec.element.library);
    // If it's a real field, it's a [VariableDeclaration] which is guaranteed
    // to have parent node [VariableDeclarationList] giving the type.
    final fieldDeclaration = parsedLibrary.getElementDeclaration(element);
    // print(fieldDeclaration != null);
    if (fieldDeclaration != null) {
      return (((fieldDeclaration.node as VariableDeclaration).parent) as VariableDeclarationList)
              .type
              ?.toSource() ??
          'dynamic';
    } else {
      // Otherwise it's an explicit getter/setter pair; get the type from the getter.
      return (parsedLibrary.getElementDeclaration(element.getter!)!.node as MethodDeclaration)
              .returnType
              ?.toSource() ??
          'dynamic';
    }
  }

  static bool _isParam(ClassElement classElement, FieldElement element) {
    if (element.isPrivate) return false;
    if (element.hasInitializer) return false;

    final constructorElement = classElement.unnamedConstructor ?? classElement.constructors.first;
    return constructorElement.parameters.any((e) => e.name == element.name);
  }
}
