It allows to get beautiful class to string.
Generally used in code generators for example in [mek_data_class]

## Features

- [x] Supported nested classes
- [x] Generate a single-line string from a class
- [x] Generate a multi-line string from a class
- [ ] Generate a json string from a class
- [ ] Generate a yaml string from a class

## Usage

Follow the example and remember that null values will not be included

```dart
class Product {
  final String name;
  final double? price;

  const Product({required this.name, this.price});
  
  String toString() =>
      (ClassToString('Product')
        ..add('name', name)..add('price', price)).toString();
} 
```

## Additional information

If you can add support for `json` and `yaml`!
If you can improve the readability by differentiating a string from a number! For example `"12"` and `12`

[mek_data_class]: https://pub.dartlang.org/packages/mek_data_class