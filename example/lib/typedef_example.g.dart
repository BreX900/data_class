// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typedef_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Extra {
  Extra get _self => this as Extra;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Extra &&
          runtimeType == other.runtimeType &&
          $mapEquality.equals(_self.jsonMap, other.jsonMap) &&
          $mapEquality.equals(_self.nullableJsonMap, other.nullableJsonMap) &&
          _self.product == other.product &&
          _self.product2 == other.product2;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, $mapEquality.hash(_self.jsonMap));
    hashCode = $hashCombine(hashCode, $mapEquality.hash(_self.nullableJsonMap));
    hashCode = $hashCombine(hashCode, _self.product.hashCode);
    hashCode = $hashCombine(hashCode, _self.product2.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('Extra')
        ..add('jsonMap', _self.jsonMap)
        ..add('nullableJsonMap', _self.nullableJsonMap)
        ..add('product', _self.product)
        ..add('product2', _self.product2))
      .toString();
  Extra copyWith({
    Map<String, int>? jsonMap,
    Map<String, double?>? nullableJsonMap,
    Product? product,
    Product? product2,
  }) {
    return Extra(
      jsonMap: jsonMap ?? _self.jsonMap,
      nullableJsonMap: nullableJsonMap ?? _self.nullableJsonMap,
      product: product ?? _self.product,
      product2: product2 ?? _self.product2,
    );
  }

  Extra change(void Function(_ExtraChanges c) updates) =>
      (_ExtraChanges._(_self)..update(updates)).build();
  _ExtraChanges toChanges() => _ExtraChanges._(_self);
}

class _ExtraChanges {
  _ExtraChanges._(Extra dc)
      : jsonMap = dc.jsonMap,
        nullableJsonMap = dc.nullableJsonMap,
        product = dc.product,
        product2 = dc.product2;

  Map<String, int>? jsonMap;

  Map<String, double?> nullableJsonMap;

  Product product;

  Product product2;

  void update(void Function(_ExtraChanges c) updates) => updates(this);

  Extra build() => Extra(
        jsonMap: jsonMap,
        nullableJsonMap: nullableJsonMap,
        product: product,
        product2: product2,
      );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Extra _$ExtraFromJson(Map<String, dynamic> json) => Extra(
      jsonMap: (json['jsonMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      nullableJsonMap: (json['nullableJsonMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num?)?.toDouble()),
      ),
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      product2: Product.fromJson(json['product2'] as Map<String, dynamic>),
    );
