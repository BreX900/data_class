import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
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
  final ClassElement element;
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

  late final selfTypes =
      element.typeParameters.map((e) => e.getDisplayString(withNullability: true));

  late final List<String> _fullJoinedTypes =
      element.typeParameters.map((e) => e.getDisplayString(withNullability: true)).toList();
  late final List<String> _types = element.typeParameters.map((e) => e.displayName).toList();

  static String t(Iterable<String> t) => t.isEmpty ? '' : '<${t.join(', ')}>';

  late final NameSpec self = NameSpec(
    name: element.name,
    fullTypes: _fullJoinedTypes,
    types: _types,
  );

  late final NameSpec mixin = NameSpec(
    name: '_\$${element.name}',
    fullTypes: _fullJoinedTypes,
    types: _types,
  );

  late final NameSpec changes = NameSpec(
    name: '${changesVisible ? '' : '_'}${element.name}Changes',
    fullTypes: _fullJoinedTypes,
    types: _types,
  );

  late final NameSpec builder = NameSpec(
    name: '${element.name}Builder',
    fullTypes: _fullJoinedTypes,
    types: _types,
  );

  factory ClassSpec.from(Config config, ClassElement element, ConstantReader annotation) {
    return ClassSpec(
      element: element,
      types: element.typeParameters.map((e) => e.displayName).toList(),
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
    final constructor = element.unnamedConstructor ?? element.constructors.first;
    final parameters = constructor.parameters.map((param) {
      return param.isNamed ? '${param.name}: ${params[param.name]!},' : '${params[param.name]!},';
    });
    return '${self.name}(${parameters.join()})';
  }
}

enum Nullability { none, inherit, always }

class FieldSpec {
  final ParsedLibraryResult parsedLibrary;
  final FieldElement element;

  final String name;
  final bool comparable;
  final DartObject? equality;
  final bool stringify;
  final String? stringifier;
  final bool updatable;

  late final bool isParam = _isParam(element.enclosingElement as InterfaceElement, element);

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

    return FieldSpec(
      parsedLibrary: parsedLibrary,
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
    final prefixedElements = element.library.libraryImports.expand<Element>((e) {
      if (e.prefix == null) return [];
      return e.namespace.definedNames.values;
    });

    final type = prefixedElements.contains(element.type.element)
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

  static bool _isParam(InterfaceElement classOrMixinElement, FieldElement element) {
    if (element.isPrivate) return false;
    if (element.hasInitializer) return false;

    final constructorElement =
        classOrMixinElement.unnamedConstructor ?? classOrMixinElement.constructors.first;
    return constructorElement.parameters.any((e) => e.name == element.name);
  }
}
