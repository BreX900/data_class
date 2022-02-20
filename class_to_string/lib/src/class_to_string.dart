import 'package:class_to_string/src/class_to_flat_string.dart';
import 'package:class_to_string/src/class_to_indent_string.dart';
import 'package:class_to_string/src/class_to_json_string.dart';

/// Interface for [Object.toString] output pretty class to string.
abstract class ClassToString {
  /// Override this method to change the way a class's toString is generated
  static ClassToString Function(String name, [Iterable<Type>? types])? creator;

  /// Constructor to use the default [ClassToString]
  factory ClassToString(String name, [Iterable<Type> types = const []]) {
    if (creator != null) return creator!(name, types);
    return ClassToIndentString(name, types);
  }

  /// A [ClassToString] that produces single line output.
  factory ClassToString.flat(String name, [Iterable<Type> types]) = ClassToFlatString;

  /// A [ClassToString] that produces multi-line indented output.
  factory ClassToString.indent(String name, [Iterable<Type> types]) = ClassToIndentString;

  /// A [ClassToString] that produces json output.
  factory ClassToString.json(String name, [Iterable<Type> types]) = ClassToJsonString;

  /// Add a field and its value.
  void add(String field, Object? value);

  /// Returns to completed toString(). The helper may not be used after this
  /// method is called.
  @override
  String toString();
}
