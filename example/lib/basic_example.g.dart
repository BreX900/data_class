// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$Product {
  Product get _self => this as Product;

  Iterable<Object?> get _props sync* {
    yield _self.id;
    yield _self.title;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Product &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

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

  Product change(void Function(_ProductChanges c) updates) =>
      (_ProductChanges._(_self)..update(updates)).build();

  _ProductChanges toChanges() => _ProductChanges._(_self);
}

class _ProductChanges {
  late int id;
  late String? title;

  _ProductChanges._(Product dataClass) {
    replace(dataClass);
  }

  void update(void Function(_ProductChanges c) updates) => updates(this);

  void replace(covariant Product dataClass) {
    id = dataClass.id;
    title = dataClass.title;
  }

  Product build() => Product(
        id: id,
        title: title,
      );
}
