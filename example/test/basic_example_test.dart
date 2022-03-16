import 'package:example/basic_example.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('basic_example', () {
    final mouse1 = Product(
      id: 1,
      title: 'mouse',
    );
    final mouse2 = Product(
      id: 1,
      title: 'mouse',
    );
    final monitor = Product(
      id: 2,
      title: 'monitor',
    );

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
