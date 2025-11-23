import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mek_data_class_generator/src/configs/class_config.dart';
import 'package:mek_data_class_generator/src/configs/options.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

class ClassElements {
  final Options options;
  final ClassElement element;

  late final ConstructorElement constructor =
      element.unnamedConstructor ?? element.constructors.first;
  late final List<FieldElement> allFields = element.thisType.typeImplementations
      .expand(_fieldsOf)
      .toList();
  late final List<GetterElement> allGetters = element.thisType.typeImplementations
      .expand(_gettersOf)
      .toList();

  ClassElements({required this.options, required this.element});

  static final _configs = Expando<ClassConfig>();
  ClassConfig get config => configOf(element);

  ClassConfig configOf(ClassElement element) =>
      _configs[element] ??= ClassConfig.fromElement(options, element);

  ClassElements? elementsOf(FormalParameterElement parameter) {
    final element = parameter.type.element;
    if (element is! ClassElement) return null;
    return ClassElements(options: options, element: element);
  }

  bool containsField(String displayName) => allFields.any((e) => e.displayName == displayName);

  TypedClassElements? get superElements {
    final supertype = element.supertype;
    if (supertype == null) return null;

    final superelement = supertype.element;
    if (superelement is! ClassElement) return null;

    return TypedClassElements(options: options, type: supertype, element: superelement);
  }

  static Iterable<FieldElement> _fieldsOf(DartType type) sync* {
    final element = type.element;
    if (element is! ClassElement) return;

    for (final field in element.fields) {
      if (field.isStatic) continue;

      if (!field.isFinal) {
        if (field.setter == null) continue;
        throw InvalidGenerationSource(
          'A comparable class cannot have `var` fields.',
          element: field,
        );
      }

      yield field;
    }
  }

  static Iterable<GetterElement> _gettersOf(DartType type) sync* {
    final element = type.element;
    if (element is! ClassElement) return;

    for (final getter in element.getters) {
      if (getter.isStatic) continue;

      yield getter;
    }
  }
}

class TypedClassElements extends ClassElements {
  final InterfaceType type;

  TypedClassElements({required super.options, required this.type, required super.element});
}
