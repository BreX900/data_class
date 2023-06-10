import 'dart:convert';

import 'package:class_to_string/src/class_to_string.dart';
import 'package:class_to_string/src/class_to_string_base.dart';

/// A [ClassToString] that produces single line output.
///
/// Note: this is an experimental feature. API may change without a major
/// version increase.
class ClassToJsonString extends ClassToStringBase {
  StringBuffer? _result = StringBuffer();
  Map<String, dynamic>? _result2 = {};

  static int _isJsonString = 0;
  static String? _previousString;

  ClassToJsonString(String className, [Iterable<Type> types = const []]) {
    _isJsonString += 1;

    _result2!['\$className'] = className;
    if (types.isNotEmpty) _result2!['\$classTypes'] = '[${types.join(',')}]';

    _result!
      ..write('{"\$className":')
      ..write(jsonEncode(className));
    if (types.isNotEmpty) {
      _result!
        ..write(',"\$classTypes":')
        ..write(jsonEncode(types));
    }
  }

  @override
  void add(String name, Object? value) {
    _result2![name] = value;

    _result!
      ..write(',"')
      ..write(name)
      ..write('":');
    if (value == null ||
        value is num ||
        value is bool ||
        value is String ||
        value is List ||
        value is Map) {
      _result!.write(jsonEncode(value));
    } else {
      final result = value.toString();
      _result!.write(identical(_previousString, result) ? result : jsonEncode(result));
    }
  }

  @override
  String toString() {
    _result!.write('}');
    _isJsonString -= 1;
    final result = _previousString = _result!.toString();
    if (_isJsonString <= 0) _previousString = null;
    _result = null;
    _result2 = null;
    return result;
  }
}
