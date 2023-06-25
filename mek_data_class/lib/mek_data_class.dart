/// Support for doing something awesome.
///
/// More dartdocs go here.
library mek_data_class;

import 'package:collection/collection.dart';
import 'package:meta/meta_meta.dart';

export 'package:class_to_string/class_to_string.dart' show ClassToString;
export 'package:mek_data_class/src/data_collection_equality.dart';
export 'package:mek_data_class/src/helpers.dart';
export 'package:mek_data_class/src/optional_equality.dart';

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
  /// Inserting `stringify_type: fields` in the yaml file, the toString method will use all the fields
  final bool? stringify;

  /// Create a build class function and `*Builder` class.
  /// Default: `false`
  final bool? buildable;

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

  /// Makes public the `*Fields` classes generated when [createFieldsClass] is enabled.
  /// Default: `true`
  final bool? fieldsClassVisible;

  /// This equality is used in the following methods [Object.==] and [Object.hashCode].
  final List<Equality<dynamic>> equalities;

  /// Ex.
  /// @DataClass()
  /// class Product {}
  const DataClass({
    this.comparable,
    this.stringify,
    this.copyable,
    this.buildable,
    this.changeable,
    this.changesVisible,
    this.createFieldsClass,
    this.fieldsClassVisible,
    this.equalities = const [],
  });

  /// Used by mek_data_class_generator
  @Deprecated('Update mek_data_class_generator package and run code generation with build_runner.')
  static bool $equals(Iterable<Object?> self, Iterable<Object?> other) {
    return const IterableEquality<Object?>(DeepCollectionEquality()).equals(self, other);
  }
}

/// Customize data class field generation
@Target({TargetKind.field})
class DataField {
  /// It will be considered in the [Object.==] and [Object.hashCode] methods.
  final bool comparable;

  /// This equality is used in the following methods [Object.==] and [Object.hashCode].
  final Equality<dynamic>? equality;

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
    this.equality,
    this.stringify = true,
    this.updatable = true,
    this.stringifier,
  });
}
