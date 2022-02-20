The purpose of this library is to expose the generation of very simple class methods with excellent performance and little code generation.
For this you will only be able to enable what you need of the supported features

## Features
Auto generation of:
- [x] Inheritance and generic classes supported
- [x] `hashCode` and `==` methods
- [x] pretty `toString` method
- [x] `copyWith` method
- [x] `*Changes` class and `change`, `toChanges` methods in data class
- [ ] `*Builder` class and `rebuild`, `toBuilder` methods in data class

## Install package

To use [DataClass], you will need your typical [build_runner]/code-generator setup.
First, install [build_runner], data_class, [data_class_generator] by adding them to your pubspec.yaml file:

```yaml
# pubspec.yaml
dependencies:
  mek_data_class:

dev_dependencies:
  build_runner:
  mek_data_class_generator:
```

## Run the generator

To run the code generator you can use:
- `<dart|flutter> pub run build_runner build`

As such, a file that wants to use [DataClass] will start with:

```dart
import 'package:mek_data_class/mek_data_class.dart';

part 'my_file.g.dart';
```

## Usage/Examples

You can see some examples in 
- [basic](/example/lib/basic_example.dart)
- [generics](/example/lib/generics_example.dart)
- [inheritance](/example/lib/inheritance_example.dart)

### Basic

Because the boiler plate is generated as a mixin, it is minimally intrusive on the interface of the class.
You only have to provide a constructor with named arguments for all fields and extend the generated mixin.

```dart
@DataClass()
class Product with _$Product {
  final String title;
  final double price;

  const Product({
    required this.title,
    required this.price,
  });
  
  String get titlePrice => '$title$price';
}
```

### Inheritance
Taking into consideration the previous example you can write and inherit all methods

```dart
@DataClass()
class PrettyProduct extends Product with _$PrettyProduct {
  final String color;

  const Product({
    required String title,
    required double price,
    required this.color,
  }) : super(title: title, price: price);

  String get titlePriceColor => '$titlePrice$color';
}
```

### Generics
You can also declare classes with generic types

```dart
@DataClass()
class Value<T> with _$Value<T> {
  final T value;

  const Product({
    required this.value,
  });
}
```

### Pretty string
Use the [ClassToString] package to perform the `toString` method
```dart
final product = Product(...);
print(product);
/// Product(
///   title=Overlord,
///   price=12,
/// )
```

### CopyWith
The classic copyWith, need explanations? No, but try to prefer using `*Changes` which supports nullability
```dart
final product = Product(...);
print(product.copyWith(title: 'Raisekamika'));
```

> Enable in `build.yaml` with `copyable: true`

### *Changes
Unlike a builder you cannot set values to null but the field is not defined as such and cannot be instantiated
```dart
final product = Product(...);

final inlineUpdateProduct = product.change((changes) => changes.title = 'Raisekamika');

final updateProduct = product.toChanges();
changes.title = 'Raisekamika';
final updatedProduct = changes.build();
```

> Enable in `build.yaml` with `changeable: true`

## Global Configs
See the docs of the DataClass class for more information

```yaml
# build.yaml
targets:
  $default:
    builders:
      mek_data_class_generator|data_class:
        enabled: true
        options:
          pageWidth: 80
          comparable: true
          stringify: true
          copyable: false
          changeable: false
          changesVisible: false
```

## Motivations
- Some packages generate a lot of code and mess with the normal, classic class construction in dart.
  Also you can't easily select classes without any problem, without having to create mixins for the methods
- Some packages require you to mark all your fields with @override

> Similar packages [freezed], [built_value],  [dataclass_beta],  [functional_data]

## Additional information

[build_runner]: https://pub.dev/packages/build_runner
[DataClass]: https://pub.dartlang.org/packages/mek_data_class
[data_class_generator]: https://pub.dartlang.org/packages/mek_data_class_generator
[ClassToString]: https://pub.dartlang.org/packages/class_to_string
[freezed]: https://pub.dartlang.org/packages/freezed
[built_value]: https://pub.dartlang.org/packages/freezed
[dataclass_beta]: https://pub.dartlang.org/packages/dataclass_beta
[functional_data]: https://pub.dartlang.org/packages/functional_data