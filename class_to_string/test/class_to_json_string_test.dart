import 'package:class_to_string/src/class_to_json_string.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ClassToJsonString', () {
    test('empty flat class', () {
      final object = FakeClass(() => ClassToJsonString('Empty'));

      expect(object.toString(), '{"\$className":"Empty"}');
    });

    test('filled flat class', () {
      final object = FakeClass(() => ClassToJsonString('Filled')
        ..add('integer', 1)
        ..add('double', 1.1)
        ..add('boolean', true)
        ..add('string', 'text')
        ..add('null', null)
        ..addIfExist('nullable', null));

      expect(object.toString(),
          '{"\$className":"Filled","integer":1,"double":1.1,"boolean":true,"string":"text","null":null}');
    });

    test('inner flat class', () {
      final object = FakeClass(() => ClassToJsonString('External')
        ..add('externalValue', 1.1)
        ..add('class', FakeClass(() {
          return ClassToJsonString('Internal')..add('innerValue', true);
        })));

      expect(object.toString(),
          '{"\$className":"External","externalValue":1.1,"class":{"\$className":"Internal","innerValue":true}}');
    });
  });
}
