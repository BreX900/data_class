// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typedef_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Extra {
  Extra get _self => this as Extra;
  Iterable<Object?> get _props sync* {
    yield _self.jsonMap;
    yield _self.nullableJsonMap;
    yield _self.product;
    yield _self.product2;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Extra &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);
  @override
  int get hashCode => Object.hashAll(_props);
  @override
  String toString() => (ClassToString('Extra')
        ..add('jsonMap', _self.jsonMap)
        ..add('nullableJsonMap', _self.nullableJsonMap)
        ..add('product', _self.product)
        ..add('product2', _self.product2))
      .toString();
  Extra copyWith({
    JsonMap<int>? jsonMap,
    NullableJsonMap<double?>? nullableJsonMap,
    be.Product? product,
    be.Product? product2,
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

  JsonMap<int>? jsonMap;

  NullableJsonMap<double?> nullableJsonMap;

  be.Product product;

  be.Product product2;

  void update(void Function(_ExtraChanges c) updates) => updates(this);
  Extra build() => Extra(
        jsonMap: jsonMap,
        nullableJsonMap: nullableJsonMap,
        product: product,
        product2: product2,
      );
}
