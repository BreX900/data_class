import 'package:class_to_string/src/class_to_string.dart';

/// A [ClassToString] that produces multi-line indented output.
class ClassToIndentString implements ClassToString {
  StringBuffer? _result = StringBuffer();

  static var _indentCount = 0;

  var _isEmpty = true;

  ClassToIndentString(String className, [Iterable<Type> types = const []]) {
    _result!.write(className);
    if (types.isNotEmpty) {
      _result!.write('<');
      int i = 0;
      for (final type in types) {
        if (i++ > 0) _result!.write(',');
        _result!.write(type);
      }
      _result!.write('>');
    }
    _result!.write('(');
    _indentCount += 2;
  }

  @override
  void add(String field, Object? value) {
    if (value == null) return;
    if (_isEmpty) {
      _isEmpty = false;
      _result!.writeln();
    }
    _result!
      ..write(' ' * _indentCount)
      ..write(field)
      ..write('=')
      ..write(value)
      ..write(',\n');
  }

  @override
  String toString() {
    _indentCount -= 2;
    if (!_isEmpty) _result!.write(' ' * _indentCount);
    _result!.write(')');
    final stringResult = _result.toString();
    _result = null;
    return stringResult;
  }
}
