// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typedef_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Extra {
  Extra get _self => this as Extra;
  Extra copyWith({
    $Parameter<JsonMap<int>?> jsonMap = const Unspecified(),
    $Parameter<NullableJsonMap<double?>> nullableJsonMap = const Unspecified(),
    $Parameter<Product> product = const Unspecified(),
    $Parameter<Product> product2 = const Unspecified(),
  }) {
    return Extra(
      jsonMap: Unspecified.resolve(_self.jsonMap, jsonMap),
      nullableJsonMap:
          Unspecified.resolve(_self.nullableJsonMap, nullableJsonMap),
      product: Unspecified.resolve(_self.product, product),
      product2: Unspecified.resolve(_self.product2, product2),
    );
  }

  Extra change(void Function(ExtraChanges c) updates) =>
      (toChanges()..update(updates)).build();
  ExtraChanges toChanges() => ExtraChanges._(_self);
  Extra rebuild(void Function(ExtraBuilder b) updates) =>
      (toBuilder()..update(updates)).build();
  ExtraBuilder toBuilder() => ExtraBuilder()..replace(_self);
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
}

class ExtraChanges {
  ExtraChanges._(this._original);

  final Extra _original;

  late JsonMap<int>? jsonMap = _original.jsonMap;

  late NullableJsonMap<double?> nullableJsonMap = _original.nullableJsonMap;

  late ProductChanges product = _original.product.toChanges();

  late ProductChanges product2 = _original.product2.toChanges();

  void update(void Function(ExtraChanges c) updates) => updates(this);

  Extra build() {
    return Extra(
      jsonMap: jsonMap,
      nullableJsonMap: nullableJsonMap,
      product: product.build(),
      product2: product2.build(),
    );
  }
}

class ExtraBuilder {
  JsonMap<int>? jsonMap;

  NullableJsonMap<double?>? nullableJsonMap;

  Product? product;

  Product? product2;

  void update(void Function(ExtraBuilder b) updates) => updates(this);

  Extra build() {
    return Extra(
      jsonMap: jsonMap,
      nullableJsonMap:
          ArgumentError.checkNotNull(nullableJsonMap, 'nullableJsonMap'),
      product: ArgumentError.checkNotNull(product, 'product'),
      product2: ArgumentError.checkNotNull(product2, 'product2'),
    );
  }

  void replace(covariant Extra other) {
    jsonMap = other.jsonMap;
    nullableJsonMap = other.nullableJsonMap;
    product = other.product;
    product2 = other.product2;
  }
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
