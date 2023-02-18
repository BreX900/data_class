import 'package:example/basic_example.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('basic_example', () {
    final mouse1 = Product(1, 'mouse', extraData: {});
    final mouse2 = Product(1, 'mouse', extraData: {});
    final monitor = Product(2, 'monitor', extraData: {});

    test('Success data class comparison', () {
      expect(mouse1, mouse2);
      expect(mouse1.hashCode, mouse2.hashCode);
    });

    test('Failed data class comparison', () {
      expect(mouse1, isNot(monitor));
      expect(mouse1.hashCode, isNot(monitor.hashCode));
    });
  });
}
