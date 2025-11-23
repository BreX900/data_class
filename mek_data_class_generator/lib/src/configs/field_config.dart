import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class FieldConfig {
  static const _typeChecker = TypeChecker.typeNamed(DataField, inPackage: 'mek_data_class');

  final bool equatable;
  final DartObject? equality;
  final bool stringify;
  final String? stringifier;

  const FieldConfig({
    required this.equatable,
    required this.equality,
    required this.stringify,
    required this.stringifier,
  });

  factory FieldConfig.fromElement(FieldElement element) {
    final annotation = ConstantReader(_typeChecker.firstAnnotationOf(element));
    if (annotation.isNull) {
      return const FieldConfig(equatable: true, equality: null, stringify: true, stringifier: null);
    }
    return FieldConfig(
      equatable: annotation.read('equatable').boolValue,
      equality: annotation.get('equality')?.objectValue,
      stringify: annotation.read('stringify').boolValue,
      stringifier: annotation.get('stringifier')?.revive().accessor,
    );
  }
}
