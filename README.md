[![pub package](https://img.shields.io/badge/GitHub-0.0.1-brightgreen)](https://github.com/BreX900/data_class)
[![pub package](https://img.shields.io/badge/pub.dev-0.0.1-blue)](https://pub.dartlang.org/packages/mek_data_class)

The purpose of this library is to expose the generation of very simple class methods with excellent performance and little code generation.
For this you will only be able to enable what you need of the supported features

## Features
Auto generation of:
- [x] Inheritance and generic classes supported
- [x] `hashCode` and `==` methods
- [x] pretty `toString` method
- [x] `copyWith` method with support a `null` values
- [x] `*Changes` class to updated your data class
- [x] `*Builder` class to build or update your data class

## Install package

To use [DataClass], you will need your typical [build_runner]/code-generator setup.
First, install [build_runner], [data_class], [data_class_generator] by adding them to your pubspec.yaml file:

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
- [basic](https://github.com/BreX900/data_class/blob/main/example/lib/basic_example.dart)
- [generics](https://github.com/BreX900/data_class/blob/main/example/lib/generics_example.dart)
- [inheritance](https://github.com/BreX900/data_class/blob/main/example/lib/inheritance_example.dart)

### Basic

Because the boiler plate is generated as a mixin, it is minimally intrusive on the interface of the class.
You only have to provide a constructor with positional or named arguments for all fields and extend the generated mixin.

```dart
@DataClass()
class Product with _$Product {
  final String title;
  final double price;

  const Product({
    required this.title,
    required this.price,
  });
}
```

Customization of the equal operator and hashcode through the use of the Equality class is supported. [See example.](https://github.com/BreX900/data_class/blob/main/example/lib/equality_example.dart)

### Inheritance
Taking into consideration the previous example you can write and inherit all methods

```dart
@DataClass()
class PrettyProduct extends Product with _$PrettyProduct {
  final String color;

  const Product({
    required super.title,
    required super.price,
    required this.color,
  });

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
/// Product(
///   title: "Overlord",
///   price: 12,
/// )
print(product);
```

### CopyWith
The classic copyWith, need explanations? No, but it also supports `null` values!
```dart
final product = Product(...);
print(product.copyWith(title: 'Raisekamika'));
```

> Enable in `DataClass` annotation or `build.yaml` file with `copyable: true`

### *Changes
Unlike a builder you cannot set values to null but the field is not defined as such and cannot be instantiated

```dart
final updatedProduct = product.change((changes) => changes..title = 'Raisekamika');

final changes = product.toChanges();
changes.title = 'Raisekamika';
final updatedProduct = changes.build();
```

> Enable in `DataClass` annotation or `build.yaml` file with `changeable: true`

#### *Changes.update
Update the `*Changes` class by passing a function
```dart 
final updatedChanges = changes.update((c) => c..title = 'Albedo'); // title=Albedo
```

#### *Changes.replace
Update the properties of the `*Changes` class with the properties of the `DataClass`
```dart 
final updatedChanges = productChanges.replace(product); // title=Raisekamika
```

#### *Changes.build
Build the `DataClass` from `*Changes` class
```dart 
Product product = productChanges.build();
```

### *Builder
Build your class using a builder.
It is not safe to construct a class using a builder but it allows you to complete the construction whenever you want.
```dart
@DataClass(buildable: true)
class Product with _$Product {
  final int id;
  const Product({required this.id});
  factory Product.build(void Function(ProductBuilder b) updates) => 
          (ProductBuilder().update(updates)).build();
}

final builder = ProductBuilder();
builder.id = 12;
final product = builder.build();
```

## Global Configs
See the docs of the DataClass class for more information

```yaml
# build.yaml
targets:
  $default:
    builders:
      mek_data_class_generator:
        enabled: true
        options:
          equatable: true
          stringify: true
          stringify_if_null: true # if set to `false`, null values will not be included in the toString 
          buildable: false
          copyable: false
          changeable: false
```

## Motivations
- Some packages generate a lot of code and mess with the normal, classic class construction in dart.
  Also you can't easily select classes without any problem, without having to create mixins for the methods
- Some packages require you to mark all your fields with @override

> Similar packages [freezed], [built_value],  [dataclass_beta],  [functional_data]



[build_runner]: https://pub.dev/packages/build_runner
[DataClass]: https://pub.dartlang.org/packages/mek_data_class
[data_class]: https://pub.dartlang.org/packages/mek_data_class
[data_class_generator]: https://pub.dartlang.org/packages/mek_data_class_generator
[ClassToString]: https://pub.dartlang.org/packages/class_to_string
[freezed]: https://pub.dartlang.org/packages/freezed
[built_value]: https://pub.dartlang.org/packages/freezed
[dataclass_beta]: https://pub.dartlang.org/packages/dataclass_beta
[functional_data]: https://pub.dartlang.org/packages/functional_data