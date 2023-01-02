// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides, unused_element

mixin _$Order {
  Order get _self => this as Order;

  Iterable<Object?> get _props sync* {}

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props) &&
          const ProductEquality().equals(_self.product, other.product);

  int get hashCode => Object.hashAll(
      _props.followedBy([const ProductEquality().hash(_self.product)]));

  String toString() =>
      (ClassToString('Order')..add('product', _self.product)).toString();

  Order change(void Function(_OrderChanges c) updates) =>
      (_OrderChanges._(_self)..update(updates)).build();

  _OrderChanges toChanges() => _OrderChanges._(_self);
}

class _OrderChanges {
  Product product;

  _OrderChanges._(Order dc) : product = dc.product;

  void update(void Function(_OrderChanges c) updates) => updates(this);

  Order build() => Order(
        product: product,
      );
}

mixin _$Product {
  Product get _self => this as Product;

  Iterable<Object?> get _props sync* {
    yield _self.title;
    yield _self.extraData;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('Product')
        ..add('id', _self.id)
        ..add('title', _self.title))
      .toString();

  Product copyWith({
    int? id,
    Map<String, int?>? extraData,
  }) {
    return Product(
      id: id ?? _self.id,
      title: _self.title,
      extraData: extraData ?? _self.extraData,
    );
  }

  Product change(void Function(_ProductChanges c) updates) =>
      (_ProductChanges._(_self)..update(updates)).build();

  _ProductChanges toChanges() => _ProductChanges._(_self);
}

class _ProductChanges {
  final Product _dc;
  int id;
  Map<String, int?>? extraData;

  _ProductChanges._(this._dc)
      : id = _dc.id,
        extraData = _dc.extraData;

  void update(void Function(_ProductChanges c) updates) => updates(this);

  Product build() => Product(
        id: id,
        title: _dc.title,
        extraData: extraData,
      );
}
