// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typedef_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides, unused_element

mixin _$Extra {
  Extra get _self => this as Extra;

  Iterable<Object?> get _props sync* {
    yield _self.jsonMap;
    yield _self.nullableJsonMap;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Extra &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('Extra')
        ..add('jsonMap', _self.jsonMap)
        ..add('nullableJsonMap', _self.nullableJsonMap))
      .toString();

  Extra copyWith({
    JsonMap<int>? jsonMap,
    NullableJsonMap<double?>? nullableJsonMap,
  }) {
    return Extra(
      jsonMap: jsonMap ?? _self.jsonMap,
      nullableJsonMap: nullableJsonMap ?? _self.nullableJsonMap,
    );
  }

  Extra change(void Function(_ExtraChanges c) updates) =>
      (_ExtraChanges._(_self)..update(updates)).build();

  _ExtraChanges toChanges() => _ExtraChanges._(_self);
}

class _ExtraChanges {
  late JsonMap<int>? jsonMap;
  late NullableJsonMap<double?> nullableJsonMap;

  _ExtraChanges._(Extra dataClass) {
    replace(dataClass);
  }

  void update(void Function(_ExtraChanges c) updates) => updates(this);

  void replace(covariant Extra dataClass) {
    jsonMap = dataClass.jsonMap;
    nullableJsonMap = dataClass.nullableJsonMap;
  }

  Extra build() => Extra(
        jsonMap: jsonMap,
        nullableJsonMap: nullableJsonMap,
      );
}
