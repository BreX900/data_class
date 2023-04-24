// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equality_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Order {
  Order get _self => this as Order;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          const ProductEquality().equals(_self.product, other.product) &&
          const $NullableEquality(ProductEquality())
              .equals(_self.freeProduct, other.freeProduct);
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode =
        $hashCombine(hashCode, const ProductEquality().hash(_self.product));
    hashCode = $hashCombine(hashCode,
        const $NullableEquality(ProductEquality()).hash(_self.freeProduct));
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('Order')
        ..add('product', _self.product)
        ..add('freeProduct', _self.freeProduct))
      .toString();
}

mixin _$Category {
  Category get _self => this as Category;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          const $CollectionEquality(ProductEquality())
              .equals(_self.products, other.products) &&
          const $CollectionEquality($NullableEquality(ProductEquality()))
              .equals(_self.freeProducts, other.freeProducts);
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode,
        const $CollectionEquality(ProductEquality()).hash(_self.products));
    hashCode = $hashCombine(
        hashCode,
        const $CollectionEquality($NullableEquality(ProductEquality()))
            .hash(_self.freeProducts));
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('Category')
        ..add('products', _self.products)
        ..add('freeProducts', _self.freeProducts))
      .toString();
}

mixin _$Product {
  Product get _self => this as Product;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          _self.id == other.id;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('Product')..add('id', _self.id)).toString();
}
