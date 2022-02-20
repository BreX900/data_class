// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$Product {
  Product get _self => this as Product;

  List<Object?> get _props => [
        _self.id,
        _self.title,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Product &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  String toString() => (ClassToString('Product')
        ..add('id', _self.id)
        ..add('title', _self.title))
      .toString();

  Product copyWith({
    int? id,
    String? title,
  }) {
    return Product(
      id: id ?? _self.id,
      title: title ?? _self.title,
    );
  }

  Product change(void Function(_ProductChanges c) updates) {
    final changes = _ProductChanges._(_self);
    updates(changes);
    return changes.build();
  }

  _ProductChanges toChanges() => _ProductChanges._(_self);
}

class _ProductChanges {
  int id;
  String title;

  _ProductChanges._(Product self)
      : id = self.id,
        title = self.title;

  Product build() => Product(
        id: id,
        title: title,
      );
}
