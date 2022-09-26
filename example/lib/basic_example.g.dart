// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides, unused_element

mixin _$Order {
  Order get _self => this as Order;

  Iterable<Object?> get _props sync* {
    yield _self.product;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Order &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() =>
      (ClassToString('Order')..add('product', _self.product)).toString();

  Order copyWith({
    Product? product,
  }) {
    return Order(
      product: product ?? _self.product,
    );
  }

  Order change(void Function(_OrderChanges c) updates) =>
      (_OrderChanges._(_self)..update(updates)).build();

  _OrderChanges toChanges() => _OrderChanges._(_self);
}

class _OrderChanges {
  late Product product;

  _OrderChanges._(Order dataClass) {
    replace(dataClass);
  }

  void update(void Function(_OrderChanges c) updates) => updates(this);

  void replace(covariant Order dataClass) {
    product = dataClass.product;
  }

  Order build() => Order(
        product: product,
      );
}

class OrderFields {
  final String _path;

  const OrderFields([this._path = '']);

  ProductFields get product => ProductFields('${_path}product.');

  String toString() => _path.isEmpty ? 'OrderFields()' : _path;
}

mixin _$Product {
  Product get _self => this as Product;

  Iterable<Object?> get _props sync* {
    yield _self.id;
    yield _self.title;
    yield _self.extraData;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Product &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('Product')
        ..add('id', _self.id)
        ..add('title', _self.title)
        ..add('extraData', _self.extraData))
      .toString();

  Product copyWith({
    int? id,
    String? title,
    Map<String, int?>? extraData,
  }) {
    return Product(
      id: id ?? _self.id,
      title: title ?? _self.title,
      extraData: extraData ?? _self.extraData,
    );
  }

  Product change(void Function(_ProductChanges c) updates) =>
      (_ProductChanges._(_self)..update(updates)).build();

  _ProductChanges toChanges() => _ProductChanges._(_self);
}

class _ProductChanges {
  late int id;
  late String? title;
  late Map<String, int?>? extraData;

  _ProductChanges._(Product dataClass) {
    replace(dataClass);
  }

  void update(void Function(_ProductChanges c) updates) => updates(this);

  void replace(covariant Product dataClass) {
    id = dataClass.id;
    title = dataClass.title;
    extraData = dataClass.extraData;
  }

  Product build() => Product(
        id: id,
        title: title,
        extraData: extraData,
      );
}

class ProductFields {
  final String _path;

  const ProductFields([this._path = '']);

  String get id => '${_path}id';
  String get title => '${_path}title';
  String get extraData => '${_path}extraData';

  String toString() => _path.isEmpty ? 'ProductFields()' : _path;
}
