import 'package:class_to_string/src/class_to_string.dart';

abstract class ClassToStringBase implements ClassToString {
  @override
  void addIfExist(String name, Object? value) {
    if (value == null) return;
    add(name, value);
  }
}
