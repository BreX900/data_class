import 'package:class_to_string/src/class_to_flat_string.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ClassToFlatString', () {
    test('empty flat class', () {
      final object = FakeClass(() => ClassToFlatString('Empty'));

      expect(object.toString(), 'Empty()');
    });

    test('filled flat class', () {
      final object = FakeClass(() {
        return ClassToFlatString('Filled')
          ..add('integer', 1)
          ..add('double', 1.1)
          ..add('boolean', true)
          ..add('string', 'text')
          ..add('null', null)
          ..addIfExist('nullable', null);
      });

      expect(
        object.toString(),
        "Filled(integer:1,double:1.1,boolean:true,string:'text',null:null)",
      );
    });

    test('inner flat class', () {
      final object = FakeClass(() {
        return ClassToFlatString('External')
          ..add('externalValue', 1.1)
          ..add(
            'class',
            FakeClass(() {
              return ClassToFlatString('Internal')..add('innerValue', true);
            }),
          );
      });

      expect(object.toString(), 'External(externalValue:1.1,class:Internal(innerValue:true))');
    });
  });
}
