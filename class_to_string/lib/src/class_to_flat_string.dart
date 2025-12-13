import 'package:class_to_string/src/class_to_string.dart';
import 'package:class_to_string/src/class_to_string_base.dart';
import 'package:class_to_string/src/utils.dart';

/// A [ClassToString] that produces single line output.
class ClassToFlatString extends ClassToStringBase {
  StringBuffer? _result = StringBuffer();

  var _isEmpty = true;

  ClassToFlatString(String className, [Iterable<Type> types = const []]) {
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
  }

  @override
  void add(String name, Object? value) {
    if (_isEmpty) {
      _isEmpty = false;
    } else {
      _result!.write(',');
    }
    _result!
      ..write(name)
      ..write(':')
      ..writeValue(value);
  }

  @override
  String toString() {
    _result!.write(')');
    final stringResult = _result.toString();
    _result = null;
    _isEmpty = true;
    return stringResult;
  }
}
