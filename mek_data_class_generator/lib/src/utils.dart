import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:source_gen/source_gen.dart';

const _dataFieldChecker = TypeChecker.typeNamed(DataField, inPackage: 'mek_data_class');

DartObject? _dataFieldAnnotation(FieldElement2 element) =>
    _dataFieldChecker.firstAnnotationOf(element) ??
    (element.getter2 == null ? null : _dataFieldChecker.firstAnnotationOf(element.getter2!));

ConstantReader dataFieldAnnotation(FieldElement2 element) =>
    ConstantReader(_dataFieldAnnotation(element));

/// Returns `true` if [element] is annotated with [DataField].
bool hasDataFieldAnnotation(FieldElement2 element) => _dataFieldAnnotation(element) != null;

const dataClassChecker = TypeChecker.typeNamed(DataClass, inPackage: 'mek_data_class');

ConstantReader? dataClassAnnotation(ClassElement2 element) {
  final dartObject = dataClassChecker.firstAnnotationOf(element, throwOnUnresolved: false);
  return dartObject == null ? null : ConstantReader(dartObject);
}

InterfaceType? findSuperDataClass(ClassElement2 element) {
  var superType = element.supertype;
  while (superType != null) {
    if (dataClassChecker.hasAnnotationOf(superType.element3)) {
      return superType;
    }
    superType = superType.element3.supertype;
  }
  return null;
}

bool isDataClassField(FieldElement2 field) {
  if (field.isStatic) return false;
  if (!field.isFinal) return false;
  return true;
}

extension DartTypeExtension on DartType {
  DartType promoteNonNullable() => element3?.library2?.typeSystem.promoteToNonNull(this) ?? this;
  bool get isNullable => nullabilitySuffix != NullabilitySuffix.none;
}

Expression literalRawString(String text) => literalString(text, raw: text.contains(r'$'));

extension DefaultConstructorClassElementExtension on ClassElement2 {
  ConstructorElement2 get defaultConstructor =>
      constructors2.firstWhereOrNull((e) => e.name3 == null) ?? constructors2.first;
}
