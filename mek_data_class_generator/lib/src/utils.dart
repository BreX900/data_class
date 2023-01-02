import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:source_gen/source_gen.dart';

const _dataFieldChecker = TypeChecker.fromRuntime(DataField);

DartObject? _dataFieldAnnotation(FieldElement element) =>
    _dataFieldChecker.firstAnnotationOf(element) ??
    (element.getter == null ? null : _dataFieldChecker.firstAnnotationOf(element.getter!));

ConstantReader dataFieldAnnotation(FieldElement element) =>
    ConstantReader(_dataFieldAnnotation(element));

/// Returns `true` if [element] is annotated with [DataField].
bool hasDataFieldAnnotation(FieldElement element) => _dataFieldAnnotation(element) != null;

final dataClassChecker = TypeChecker.fromRuntime(DataClass);

ConstantReader? dataClassAnnotation(ClassElement element) {
  // if (element == null) return null;
  final dartObject = dataClassChecker.firstAnnotationOf(element, throwOnUnresolved: false);
  return dartObject == null ? null : ConstantReader(dartObject);
}

InterfaceType? findSuperDataClass(ClassElement element) {
  InterfaceType? superType = element.supertype;
  while (superType != null) {
    if (dataClassChecker.hasAnnotationOf(superType.element2)) {
      return superType;
    }
    superType = superType.element2.supertype;
  }
  return null;
}
