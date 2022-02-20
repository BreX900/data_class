import 'dart:convert';

import 'package:class_to_string/src/class_to_string.dart';

/// A [ClassToString] that produces single line output.
class ClassToJsonString implements ClassToString {
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
  void add(String field, Object? value) {
    if (value == null) return;
    _result2![field] = value;

    _result!
      ..write(',"')
      ..write(field)
      ..write('":');
    if (value is num || value is bool || value is String || value is List || value is Map) {
      _result!.write(jsonEncode(value));
    } else {
      final result = value.toString();
      print(result);
      _result!.write(identical(_previousString, result) ? result : jsonEncode(result));
    }
  }

  @override
  String toString() {
    // var stringResult = jsonEncode(_result2, toEncodable: (e) => e.toString());
    _result!.write('}');
    _isJsonString -= 1;
    final result = _previousString = _result!.toString();
    if (_isJsonString <= 0) _previousString = null;
    _result = null;
    _result2 = null;
    return result;
  }
}

class _JsonValue {
  final Object value;

  _JsonValue(this.value);

  dynamic toJson() => value.toString();
}
