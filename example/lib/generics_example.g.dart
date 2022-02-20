// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$Response<T> {
  Response<T> get _self => this as Response<T>;

  List<Object?> get _props => [
        _self.data,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Response<T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  String toString() =>
      (ClassToString('Response', [T])..add('data', _self.data)).toString();

  Response<T> copyWith({
    T? data,
  }) {
    return Response(
      data: data ?? _self.data,
    );
  }

  Response<T> change(void Function(_ResponseChanges<T> c) updates) {
    final changes = _ResponseChanges._(_self);
    updates(changes);
    return changes.build();
  }

  _ResponseChanges<T> toChanges() => _ResponseChanges._(_self);
}

class _ResponseChanges<T> {
  T data;

  _ResponseChanges._(Response<T> self) : data = self.data;

  Response<T> build() => Response(
        data: data,
      );
}

mixin _$PaginatedResponse<T extends Object> {
  PaginatedResponse<T> get _self => this as PaginatedResponse<T>;

  List<Object?> get _props => [
        _self.data,
        _self.total,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$PaginatedResponse<T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  String toString() => (ClassToString('PaginatedResponse', [T])
        ..add('data', _self.data)
        ..add('total', _self.total))
      .toString();

  PaginatedResponse<T> copyWith({
    T? data,
    int? total,
  }) {
    return PaginatedResponse(
      data: data ?? _self.data,
      total: total ?? _self.total,
    );
  }

  PaginatedResponse<T> change(
      void Function(_PaginatedResponseChanges<T> c) updates) {
    final changes = _PaginatedResponseChanges._(_self);
    updates(changes);
    return changes.build();
  }

  _PaginatedResponseChanges<T> toChanges() =>
      _PaginatedResponseChanges._(_self);
}

class _PaginatedResponseChanges<T extends Object>
    implements _ResponseChanges<T> {
  T data;
  int total;

  _PaginatedResponseChanges._(PaginatedResponse<T> self)
      : data = self.data,
        total = self.total;

  PaginatedResponse<T> build() => PaginatedResponse(
        data: data,
        total: total,
      );
}

mixin _$ListResponse<T> {
  ListResponse<T> get _self => this as ListResponse<T>;

  List<Object?> get _props => [
        _self.data,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$ListResponse<T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  String toString() =>
      (ClassToString('ListResponse', [T])..add('data', _self.data)).toString();

  ListResponse<T> copyWith({
    List<T>? data,
  }) {
    return ListResponse(
      data: data ?? _self.data,
    );
  }

  ListResponse<T> change(void Function(_ListResponseChanges<T> c) updates) {
    final changes = _ListResponseChanges._(_self);
    updates(changes);
    return changes.build();
  }

  _ListResponseChanges<T> toChanges() => _ListResponseChanges._(_self);
}

class _ListResponseChanges<T> implements _ResponseChanges<List<T>> {
  List<T> data;

  _ListResponseChanges._(ListResponse<T> self) : data = self.data;

  ListResponse<T> build() => ListResponse(
        data: data,
      );
}
