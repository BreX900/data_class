import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
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

const dataClassChecker = TypeChecker.fromRuntime(DataClass);

ConstantReader? dataClassAnnotation(ClassElement element) {
  final dartObject = dataClassChecker.firstAnnotationOf(element, throwOnUnresolved: false);
  return dartObject == null ? null : ConstantReader(dartObject);
}

InterfaceType? findSuperDataClass(ClassElement element) {
  var superType = element.supertype;
  while (superType != null) {
    if (dataClassChecker.hasAnnotationOf(superType.element)) {
      return superType;
    }
    superType = superType.element.supertype;
  }
  return null;
}

bool isDataClassField(FieldElement field) {
  if (field.isStatic) return false;
  if (!field.isFinal) return false;
  return true;
}

extension DartTypeExtension on DartType {
  DartType promoteNonNullable() => element?.library?.typeSystem.promoteToNonNull(this) ?? this;
  bool get isNullable => nullabilitySuffix != NullabilitySuffix.none;
}
