// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_example.dart';

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
          const ProductEquality().equals(_self.product, other.product);
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode =
        $hashCombine(hashCode, const ProductEquality().hash(_self.product));
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('Order')..add('product', _self.product)).toString();
  Order change(void Function(_OrderChanges c) updates) =>
      (_OrderChanges._(_self)..update(updates)).build();
  _OrderChanges toChanges() => _OrderChanges._(_self);
}

class _OrderChanges {
  _OrderChanges._(Order dc) : product = dc.product;

  Product product;

  void update(void Function(_OrderChanges c) updates) => updates(this);
  Order build() => Order(
        product: product,
      );
}

mixin _$Product {
  Product get _self => this as Product;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          _self.title == other.title &&
          $mapEquality.equals(_self.extraData, other.extraData);
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.title.hashCode);
    hashCode = $hashCombine(hashCode, $mapEquality.hash(_self.extraData));
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('Product')
        ..add('id', _self.id)
        ..add('title', _self.title))
      .toString();
  Product copyWith({
    int? id,
    Map<String, int?>? extraData,
  }) {
    return Product(
      id ?? _self.id,
      _self.title,
      extraData: extraData ?? _self.extraData,
    );
  }

  Product change(void Function(_ProductChanges c) updates) =>
      (_ProductChanges._(_self)..update(updates)).build();
  _ProductChanges toChanges() => _ProductChanges._(_self);
}

class _ProductChanges {
  _ProductChanges._(this._dc)
      : id = _dc.id,
        extraData = _dc.extraData;

  final Product _dc;

  int id;

  Map<String, int?>? extraData;

  void update(void Function(_ProductChanges c) updates) => updates(this);
  Product build() => Product(
        id,
        _dc.title,
        extraData: extraData,
      );
}

mixin _$EmptyClass {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmptyClass && runtimeType == other.runtimeType;
  @override
  int get hashCode {
    var hashCode = 0;
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('EmptyClass')).toString();
}
