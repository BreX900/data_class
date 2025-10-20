import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

abstract final class Annotations {
  static const override = CodeExpression(Code('override'));
}

TypeReference classReferenceFrom(InterfaceType type, String suffix) {
  return TypeReference(
    (b) => b
      ..symbol = '${type.element3.displayName.nonPrivate}$suffix'
      ..types.addAll(type.typeArguments.map((e) => Reference('$e'))),
  );
}

extension TypeReferenceExtensions on TypeReference {
  String getDisplayString() {
    if (types.isEmpty) return symbol;
    return '$symbol<${types.map((e) => e.symbol).join(', ')}>';
  }
}

extension DartTypeExtensions on DartType {
  DartType promoteNonNullable() => element3?.library2?.typeSystem.promoteToNonNull(this) ?? this;

  String getAliasOrDisplayString() {
    if (alias case final element?) {
      var buffer = element.typeArguments.map((e) => e.getAliasOrDisplayString()).join(', ');
      if (buffer.isNotEmpty) buffer = '<$buffer>';
      buffer = '${element.element2.displayName}$buffer';
      if (isNullableType) buffer = '$buffer?';
      return buffer;
    }
    return getDisplayString();
  }
}

extension StringExtensions on String {
  String get nullable {
    if (endsWith('?')) return this;
    return '$this?';
  }
}

extension ConstantReaderExtensions on ConstantReader {
  ConstantReader? get(String field) {
    final reader = read(field);
    if (reader.isNull) return null;
    return reader;
  }
}
