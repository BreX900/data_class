import 'package:class_to_string/src/class_to_indent_string.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('ClassToIndentString', () {
    test('empty flat class', () {
      final stringify = FakeClass(() => ClassToIndentString('Empty'));

      expect(stringify.toString(), 'Empty()');
    });

    test('filled flat class', () {
      final object = FakeClass(() => ClassToIndentString('Filled')
        ..add('integer', 1)
        ..add('double', 1.1)
        ..add('boolean', true)
        ..add('string', 'text')
        ..add('null', null)
        ..addIfExist('nullable', null));

      expect(
        object.toString(),
        'Filled(\n'
        '  integer: 1,\n'
        '  double: 1.1,\n'
        '  boolean: true,\n'
        '  string: \'text\',\n'
        '  null: null,\n'
        ')',
      );
    });

    test('inner flat class', () {
      final stringify = FakeClass(() => ClassToIndentString('External')
        ..add('externalValue', 1.1)
        ..add('class', FakeClass(() {
          return ClassToIndentString('Internal')..add('innerValue', true);
        })));

      expect(
        stringify.toString(),
        'External(\n'
        '  externalValue: 1.1,\n'
        '  class: Internal(\n'
        '    innerValue: true,\n'
        '  ),\n'
        ')',
      );
    });
  });
}
