import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:mek_data_class_generator/src/configs/options.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class ClassConfig {
  static const _typeChecker = TypeChecker.typeNamed(DataClass, inPackage: 'mek_data_class');

  final bool comparable;
  final bool stringify;
  final bool buildable;
  final bool copyable;
  final bool changeable;
  final List<DartObject> equalities;

  const ClassConfig({
    required this.comparable,
    required this.stringify,
    required this.copyable,
    required this.buildable,
    required this.changeable,
    required this.equalities,
  });

  factory ClassConfig.fromElement(Options config, Element element) {
    final annotation = ConstantReader(_typeChecker.firstAnnotationOf(element));
    if (annotation.isNull) {
      return const ClassConfig(
        comparable: false,
        stringify: false,
        buildable: false,
        copyable: false,
        changeable: false,
        equalities: [],
      );
    }
    return ClassConfig.fromAnnotation(config, annotation);
  }

  factory ClassConfig.fromAnnotation(Options config, ConstantReader annotation) {
    return ClassConfig(
      comparable: annotation.get('comparable')?.boolValue ?? config.equatable,
      stringify: annotation.get('stringify')?.boolValue ?? config.stringify,
      buildable: annotation.get('buildable')?.boolValue ?? config.buildable,
      copyable: annotation.get('copyable')?.boolValue ?? config.copyable,
      changeable: annotation.get('changeable')?.boolValue ?? config.changeable,
      equalities: annotation.read('equalities').listValue,
    );
  }
}
