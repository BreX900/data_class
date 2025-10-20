// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Order {
  Order get _self => this as Order;

  Order change(void Function(OrderChanges c) updates) =>
      (toChanges()..update(updates)).build();

  OrderChanges toChanges() => OrderChanges._(_self);

  Order rebuild(void Function(OrderBuilder b) updates) =>
      (toBuilder()..update(updates)).build();

  OrderBuilder toBuilder() => OrderBuilder()..replace(_self);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          const ProductEquality().equals(_self.product, other.product) &&
          _self.isSent == other.isSent &&
          _self.isNew == other.isNew;

  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(
      hashCode,
      const ProductEquality().hash(_self.product),
    );
    hashCode = $hashCombine(hashCode, _self.isSent.hashCode);
    hashCode = $hashCombine(hashCode, _self.isNew.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('Order')
            ..add('product', _self.product)
            ..add('isSent', _self.isSent)
            ..add('isNew', _self.isNew))
          .toString();
}

class OrderChanges {
  OrderChanges._(this._original);

  final Order _original;

  late ProductChanges product = _original.product.toChanges();

  late bool? isSent = _original.isSent;

  late bool? isNew = _original.isNew;

  void update(void Function(OrderChanges c) updates) => updates(this);

  Order build() {
    return Order(product: product.build(), isSent: isSent, isNew: isNew);
  }
}

class OrderBuilder {
  Product? product;

  bool? isSent;

  bool? isNew;

  void update(void Function(OrderBuilder b) updates) => updates(this);

  Order build() {
    return Order(
      product: ArgumentError.checkNotNull(product, 'product'),
      isSent: isSent,
      isNew: isNew,
    );
  }

  void replace(covariant Order other) {
    product = other.product;
    isSent = other.isSent;
    isNew = other.isNew;
  }
}

mixin _$Product {
  Product get _self => this as Product;

  Product copyWith({
    $Parameter<int> id = const Unspecified(),
    $Parameter<Map<String, int?>?> extraData = const Unspecified(),
  }) {
    return Product(
      Unspecified.resolve(_self.id, id),
      _self.title,
      extraData: Unspecified.resolve(_self.extraData, extraData),
    );
  }

  Product change(void Function(ProductChanges c) updates) =>
      (toChanges()..update(updates)).build();

  ProductChanges toChanges() => ProductChanges._(_self);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          _self.title == other.title &&
          $mapEquality.equals(_self.extraData, other.extraData) &&
          _self.idAndTitle == other.idAndTitle;

  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.title.hashCode);
    hashCode = $hashCombine(hashCode, $mapEquality.hash(_self.extraData));
    hashCode = $hashCombine(hashCode, _self.idAndTitle.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('Product')
            ..add('id', _self.id)
            ..add('title', _self.title)
            ..add('idAndTitle', _self.idAndTitle))
          .toString();
}

class ProductChanges {
  ProductChanges._(this._original);

  final Product _original;

  late int id = _original.id;

  late Map<String, int?>? extraData = _original.extraData;

  void update(void Function(ProductChanges c) updates) => updates(this);

  Product build() {
    return Product(id, _original.title, extraData: extraData);
  }
}

mixin _$EmptyClass {
  EmptyClass get _self => this as EmptyClass;

  EmptyClass change(void Function(EmptyClassChanges c) updates) =>
      (toChanges()..update(updates)).build();

  EmptyClassChanges toChanges() => EmptyClassChanges._(_self);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmptyClass && runtimeType == other.runtimeType;

  @override
  int get hashCode {
    final hashCode = 0;
    return $hashFinish(hashCode);
  }

  @override
  String toString() => ClassToString('EmptyClass').toString();
}

class EmptyClassChanges {
  EmptyClassChanges._(this._original);

  final EmptyClass _original;

  void update(void Function(EmptyClassChanges c) updates) => updates(this);

  EmptyClass build() => _original;
}
