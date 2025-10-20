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
export 'package:mek_data_class/src/unspecified.dart';

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

  /// Create a build class function and `*Builder` class.
  /// Default: `false`
  final bool? buildable;

  /// Adds the `copyWith` method to the class.
  /// Default: `false`
  final bool? copyable;

  /// Adds the `change` and `toChanges` method to the class.
  /// Default: `false`
  final bool? changeable;

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
    this.equalities = const [],
  });
}

/// Customize data class field generation
@Target({TargetKind.field})
class DataField {
  /// It will be considered in the [Object.==] and [Object.hashCode] methods.
  final bool equatable;

  /// This equality is used in the following methods [Object.==] and [Object.hashCode].
  final Equality<dynamic>? equality;

  /// It will be considered in the [Object.toString] method
  final bool stringify;

  /// Allows you to override the toString
  final Object? Function(dynamic value)? stringifier;

  /// Ex.
  /// @DataClass()
  /// class Product {
  ///   @DataField(stringify: false)
  ///   final String field;
  /// }
  const DataField({this.equatable = true, this.equality, this.stringify = true, this.stringifier});
}

/// Customize data class parameter generation
@Target({TargetKind.parameter})
class DataParameter {
  /// It will be considered in the `copyWith` and/or `change` methods
  final bool updatable;

  /// Ex.
  /// @DataClass()
  /// class Product {
  ///   const Product({@DataParameter(updatable: false) this.field})
  /// }
  const DataParameter({this.updatable = true});
}
