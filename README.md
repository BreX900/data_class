# 🎯 Mek Data Class

[![pub package](https://img.shields.io/pub/v/mek_data_class.svg)](https://pub.dev/packages/mek_data_class)
[![GitHub](https://img.shields.io/github/stars/BreX900/data_class?style=social)](https://github.com/BreX900/data_class)
[![License](https://img.shields.io/github/license/BreX900/data_class)](https://github.com/BreX900/data_class/blob/main/LICENSE)

> **A lightweight, flexible code generator for Dart data classes** — Generate only what you need with excellent performance and minimal boilerplate! ⚡

## 📖 Table of Contents

- [Why Mek Data Class?](#-why-mek-data-class)
- [Features](#-features)
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Usage Examples](#-usage-examples)
  - [Basic Usage](#basic-usage)
  - [Inheritance](#inheritance)
  - [Generics](#generics)
  - [Pretty toString](#pretty-tostring)
  - [CopyWith](#copywith)
  - [Changes Pattern](#changes-pattern)
  - [Builder Pattern](#builder-pattern)
- [Global Configuration](#-global-configuration)
- [Comparison with Alternatives](#-comparison-with-alternatives)
- [Contributing](#-contributing)

## 🚀 Why Mek Data Class?

Mek Data Class is a **modular** code generator that gives you complete control over what gets generated. Unlike other solutions that force you into a specific pattern, you can **enable only the features you need**:

✅ **Minimal code generation** — Only generates what you ask for  
✅ **Zero intrusion** — Uses mixins to keep your class interface clean  
✅ **High performance** — Optimized generated code  
✅ **Flexible** — Works with inheritance, generics, and complex types  
✅ **Null-safe** — Full support for Dart's sound null safety  
✅ **No @override clutter** — Your code stays clean and readable

## ✨ Features

Generate **only what you need** from this powerful feature set:

| Feature | Description | Enable With |
|---------|-------------|-------------|
| 🔒 **Equality** | `hashCode` and `==` operators | `equatable: true` |
| 📝 **toString** | Pretty-printed string representation | `stringify: true` |
| 📋 **copyWith** | Immutable updates (supports null values!) | `copyable: true` |
| 🔄 **Changes** | Type-safe update pattern | `changeable: true` |
| 🏗️ **Builder** | Builder pattern for construction | `buildable: true` |

**Plus:**
- ✅ Full support for **inheritance**
- ✅ Full support for **generic classes**
- ✅ Custom equality comparers
- ✅ Per-field customization

## 🚀 Quick Start

**1. Add dependencies to `pubspec.yaml`:**
```yaml
dependencies:
  mek_data_class: ^2.1.0

dev_dependencies:
  build_runner: ^2.4.0
  mek_data_class_generator: ^2.1.0
```

**2. Create your first data class:**
```dart
import 'package:mek_data_class/mek_data_class.dart';

part 'product.g.dart';

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

**3. Run the code generator:**
```bash
dart run build_runner build
# or for Flutter projects:
flutter pub run build_runner build
```

**4. Use your data class:**
```dart
void main() {
  final product = Product(title: 'Laptop', price: 999.99);
  
  // Auto-generated equality
  final product2 = Product(title: 'Laptop', price: 999.99);
  print(product == product2); // true
  
  // Pretty toString
  print(product);
  // Product(
  //   title: "Laptop",
  //   price: 999.99,
  // )
}
```

## 📦 Installation

To use `mek_data_class`, you need a typical [build_runner] code-generation setup.

Add these packages to your `pubspec.yaml`:

```yaml
# pubspec.yaml
dependencies:
  mek_data_class: ^2.1.0

dev_dependencies:
  build_runner: ^2.4.0
  mek_data_class_generator: ^2.1.0
```

### Running the Generator

Generate code using one of these commands:

```bash
# One-time build
dart run build_runner build

# Watch for changes and rebuild automatically
dart run build_runner watch

# For Flutter projects, use:
flutter pub run build_runner build
# or
flutter pub run build_runner watch
```

### Import in Your Files

Files using `@DataClass` should include:

```dart
import 'package:mek_data_class/mek_data_class.dart';

part 'my_file.g.dart';
```

## 📚 Usage Examples

Explore detailed examples:
- 📘 [Basic Usage](https://github.com/BreX900/data_class/blob/main/example/lib/basic_example.dart)
- 🧬 [Generics](https://github.com/BreX900/data_class/blob/main/example/lib/generics_example.dart)
- 🧩 [Inheritance](https://github.com/BreX900/data_class/blob/main/example/lib/inheritance_example.dart)
- ⚖️ [Custom Equality](https://github.com/BreX900/data_class/blob/main/example/lib/equality_example.dart)

### Basic Usage

The generated code uses **mixins**, making it minimally intrusive. Just provide a constructor and extend the generated mixin:

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

**Custom Equality:**

You can customize equality and hashCode using the `Equality` class. [See example.](https://github.com/BreX900/data_class/blob/main/example/lib/equality_example.dart)

```dart
@DataClass()
class Order with _$Order {
  @DataField(equality: ProductEquality())
  final Product product;
  
  const Order({required this.product});
}
```

### Inheritance

Data classes support inheritance — child classes inherit all generated methods:

```dart
@DataClass()
class PrettyProduct extends Product with _$PrettyProduct {
  final String color;

  const PrettyProduct({
    required super.title,
    required super.price,
    required this.color,
  });

  String get titlePriceColor => '$title $price $color';
}
```

### Generics

Generic type parameters are fully supported:

```dart
@DataClass()
class Value<T> with _$Value<T> {
  final T value;

  const Value({
    required this.value,
  });
}
```

**Usage:**
```dart
final stringValue = Value<String>(value: 'Hello');
final intValue = Value<int>(value: 42);
```

### Pretty toString

Uses the [ClassToString] package for beautiful, formatted output:
```dart
final product = Product(title: 'Overlord', price: 12.99);

print(product);
// Output:
// Product(
//   title: "Overlord",
//   price: 12.99,
// )
```

### CopyWith

The classic `copyWith` method — but with **null value support**!

> 💡 **Enable with:** `@DataClass(copyable: true)` or in `build.yaml`
```dart
final product = Product(title: 'Laptop', price: 999.99);

// Update single field
final updated = product.copyWith(title: 'Gaming Laptop');
print(updated.title); // "Gaming Laptop"
print(updated.price); // 999.99

// Set nullable field to null
final cleared = product.copyWith(description: null);
```

### Changes Pattern

A type-safe way to apply multiple updates without setting values to null until you're ready.

> 💡 **Enable with:** `@DataClass(changeable: true)` or in `build.yaml`

**Basic usage:**

```dart
// Apply changes inline
final updated = product.change((changes) => changes..title = 'Raisekamika');

// Or build changes step by step
final changes = product.toChanges();
changes.title = 'Raisekamika';
changes.price = 1299.99;
final updated = changes.build();
```

**Update existing changes:**
```dart 
final updatedChanges = changes.update((c) => c..title = 'Albedo');
```

**Replace with another instance:**
```dart 
final updatedChanges = productChanges.replace(anotherProduct);
```

**Build the final object:**
```dart 
final product = productChanges.build();
```

### Builder Pattern

Build your class using the builder pattern for flexible, multi-step construction.

> 💡 **Enable with:** `@DataClass(buildable: true)` or in `build.yaml`
```dart
@DataClass(buildable: true)
class Product with _$Product {
  final int id;
  final String title;
  
  const Product({required this.id, required this.title});
  
  // Convenience factory
  factory Product.build(void Function(ProductBuilder b) updates) => 
      (ProductBuilder()..update(updates)).build();
}

// Usage
final builder = ProductBuilder();
builder.id = 42;
builder.title = 'Laptop';
final product = builder.build();

// Or use the convenience factory
final product2 = Product.build((b) => b
  ..id = 42
  ..title = 'Laptop'
);
```

## ⚙️ Global Configuration

Configure default behavior for all data classes in your project using `build.yaml`:

```yaml
# build.yaml
targets:
  $default:
    builders:
      mek_data_class_generator:
        enabled: true
        options:
          # Enable/disable features globally
          equatable: true           # Generate == and hashCode
          stringify: true           # Generate toString
          stringify_if_null: true   # Include null values in toString
          copyable: false           # Generate copyWith method
          changeable: false         # Generate Changes class
          buildable: false          # Generate Builder class
```

You can override global settings per class:

```dart
@DataClass(
  equatable: false,  // Disable for this class
  copyable: true,    // Enable for this class
)
class MyClass with _$MyClass { ... }
```

## 🆚 Comparison with Alternatives

| Feature | mek_data_class | freezed | built_value | dataclass_beta |
|---------|----------------|---------|-------------|----------------|
| **Modular features** | ✅ Choose what to generate | ❌ All or nothing | ❌ All or nothing | ⚠️ Limited |
| **Code intrusion** | ✅ Minimal (mixins) | ⚠️ Changes class structure | ⚠️ Changes class structure | ✅ Minimal |
| **Inheritance** | ✅ Full support | ❌ Limited | ❌ Limited | ⚠️ Limited |
| **Performance** | ✅ Optimized | ✅ Good | ✅ Good | ⚠️ Variable |
| **No @override** | ✅ Clean code | ❌ Requires @override | ❌ Requires @override | ✅ Clean code |
| **Null safety** | ✅ Full support | ✅ Full support | ✅ Full support | ✅ Full support |

### Why Choose Mek Data Class?

✅ **You want control** — Enable only the features you need  
✅ **You use inheritance** — Full support for extending data classes  
✅ **You value clean code** — No @override clutter, minimal boilerplate  
✅ **You need performance** — Optimized generated code  
✅ **You want flexibility** — Works with your existing class structure

## 💡 Motivations

This package was created to address common pain points with existing solutions:

- 🎯 **Excessive code generation** — Some packages generate hundreds of lines when you only need a few methods
- 🏗️ **Forced patterns** — Some packages force you to structure your classes in specific ways
- 📝 **@override everywhere** — Some packages require marking all fields with @override
- 🚫 **Limited inheritance** — Most packages don't support inheritance well

**Mek Data Class** gives you the power to choose what you need, when you need it.

## 🤝 Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue on [GitHub](https://github.com/BreX900/data_class).

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🔗 Links

- 📦 [Package on pub.dev](https://pub.dev/packages/mek_data_class)
- 💻 [GitHub Repository](https://github.com/BreX900/data_class)
- 📚 [API Documentation](https://pub.dev/documentation/mek_data_class/latest/)
- 🐛 [Issue Tracker](https://github.com/BreX900/data_class/issues)

---

**Made with ❤️ by the Dart community**

[build_runner]: https://pub.dev/packages/build_runner
[ClassToString]: https://pub.dev/packages/class_to_string
