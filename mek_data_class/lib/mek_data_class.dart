/// Support for doing something awesome.
///
/// More dartdocs go here.
library mek_data_class;

import 'package:collection/collection.dart';
import 'package:meta/meta_meta.dart';

export 'package:class_to_string/class_to_string.dart' show ClassToString;

/// Enable and customize data class generation.
///
/// Use `build.yaml` file to set these settings globally
@Target({TargetKind.classType})
class DataClass {
  /// Overrides [Object.==] and [Object.hashCode] methods.
  /// Default: `true`
  final bool? comparable;

  /// Overrides [Object.toString] method.
  /// Default: `true`
  final bool? stringify;

  /// Adds the `copyWith` method to the class.
  /// Default: `false`
  final bool? copyable;

  /// Adds the `change` and `toChanges` method to the class.
  /// Default: `false`
  final bool? changeable;

  /// Makes public the `*Changes` classes generated when [changeable] is enabled.
  /// Default: `false`
  final bool? changesVisible;

  /// Create a class with all the field names of the class
  /// Default: `false`
  final bool? createFieldsClass;

  /// Ex.
  /// @DataClass()
  /// class Product {}
  const DataClass({
    this.comparable,
    this.stringify,
    this.copyable,
    this.changeable,
    this.changesVisible,
    this.createFieldsClass,
  });

  /// Used by mek_data_class_generator
  static bool $equals(Iterable<Object?> self, Iterable<Object?> other) {
    return const IterableEquality<Object?>(DeepCollectionEquality()).equals(self, other);
  }
}

/// Customize data class field generation
@Target({TargetKind.field})
class DataField {
  /// It will be considered in the [Object.==] and [Object.hashCode] methods.
  final bool comparable;

  /// It will be considered in the [Object.toString] method
  final bool stringify;

  /// It will be considered in the `copyWith` and/or `change` methods
  final bool updatable;

  /// Allows you to override the toString
  final Object? Function(dynamic value)? stringifier;

  /// Ex.
  /// @DataClass()
  /// class Product {
  ///   @DataField(updatable: false)
  ///   final String field;
  /// }
  const DataField({
    this.comparable = true,
    this.stringify = true,
    this.updatable = true,
    this.stringifier,
  });
}
