import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mek_data_class_generator/src/configs/class_config.dart';
import 'package:mek_data_class_generator/src/configs/options.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

class ClassElements {
  final Options options;
  final ClassElement2 element;

  late final ConstructorElement2 constructor =
      element.unnamedConstructor2 ?? element.constructors2.first;
  late final List<FieldElement2> allFields =
      element.thisType.typeImplementations.expand(_fieldsOf).toList();
  late final List<GetterElement> allGetters =
      element.thisType.typeImplementations.expand(_gettersOf).toList();

  ClassElements({required this.options, required this.element});

  static final _configs = Expando<ClassConfig>();
  ClassConfig get config => configOf(element);

  ClassConfig configOf(ClassElement2 element) =>
      _configs[element] ??= ClassConfig.fromElement(options, element);

  ClassElements? elementsOf(FormalParameterElement parameter) {
    final element = parameter.type.element3;
    if (element is! ClassElement2) return null;
    return ClassElements(options: options, element: element);
  }

  bool containsField(String displayName) => allFields.any((e) => e.displayName == displayName);

  TypedClassElements? get superElements {
    final supertype = element.supertype;
    if (supertype == null) return null;

    final superelement = supertype.element3;
    if (superelement is! ClassElement2) return null;

    return TypedClassElements(options: options, type: supertype, element: superelement);
  }

  static Iterable<FieldElement2> _fieldsOf(DartType type) sync* {
    final element = type.element3;
    if (element is! ClassElement2) return;

    for (final field in element.fields2) {
      if (field.isStatic) continue;

      if (!field.isFinal) {
        if (field.setter2 == null) continue;
        throw InvalidGenerationSource('A comparable class cannot have `var` fields.',
            element: field);
      }

      yield field;
    }
  }

  static Iterable<GetterElement> _gettersOf(DartType type) sync* {
    final element = type.element3;
    if (element is! ClassElement2) return;

    for (final getter in element.getters2) {
      if (getter.isStatic) continue;

      yield getter;
    }
  }
}

class TypedClassElements extends ClassElements {
  final InterfaceType type;

  TypedClassElements({
    required super.options,
    required this.type,
    required super.element,
  });
}
