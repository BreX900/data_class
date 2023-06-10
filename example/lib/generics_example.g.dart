// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Response<T> {
  Response<T> get _self => this as Response<T>;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Response<T> &&
          runtimeType == other.runtimeType &&
          _self.data == other.data;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.data.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('Response', [T])..add('data', _self.data)).toString();
  Response<T> copyWith({T? data});
  Response<T> change(void Function(_ResponseChanges<T> c) updates);
  _ResponseChanges<T> toChanges();
}

abstract class _ResponseChanges<T> {
  _ResponseChanges._(Response<T> dc) : data = dc.data;

  T data;

  void update(void Function(_ResponseChanges<T> c) updates);
  Response<T> build();
}

mixin _$PaginatedResponse<T extends Object> {
  PaginatedResponse<T> get _self => this as PaginatedResponse<T>;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginatedResponse<T> &&
          runtimeType == other.runtimeType &&
          _self.data == other.data &&
          _self.total == other.total;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.data.hashCode);
    hashCode = $hashCombine(hashCode, _self.total.hashCode);
    return $hashFinish(hashCode);
  }

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
          void Function(_PaginatedResponseChanges<T> c) updates) =>
      (_PaginatedResponseChanges<T>._(_self)..update(updates)).build();
  _PaginatedResponseChanges<T> toChanges() =>
      _PaginatedResponseChanges._(_self);
}

class _PaginatedResponseChanges<T extends Object>
    implements _ResponseChanges<T> {
  _PaginatedResponseChanges._(PaginatedResponse<T> dc)
      : data = dc.data,
        total = dc.total;

  @override
  T data;

  int total;

  @override
  void update(void Function(_PaginatedResponseChanges<T> c) updates) =>
      updates(this);
  @override
  PaginatedResponse<T> build() => PaginatedResponse(
        data: data,
        total: total,
      );
}

mixin _$ListResponse<T> {
  ListResponse<T> get _self => this as ListResponse<T>;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListResponse<T> &&
          runtimeType == other.runtimeType &&
          $listEquality.equals(_self.data, other.data);
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, $listEquality.hash(_self.data));
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('ListResponse', [T])..add('data', _self.data)).toString();
  ListResponse<T> copyWith({List<T>? data}) {
    return ListResponse(
      data: data ?? _self.data,
    );
  }

  ListResponse<T> change(void Function(_ListResponseChanges<T> c) updates) =>
      (_ListResponseChanges<T>._(_self)..update(updates)).build();
  _ListResponseChanges<T> toChanges() => _ListResponseChanges._(_self);
}

class _ListResponseChanges<T> implements _ResponseChanges<List<T>> {
  _ListResponseChanges._(ListResponse<T> dc) : data = dc.data;

  @override
  List<T> data;

  @override
  void update(void Function(_ListResponseChanges<T> c) updates) =>
      updates(this);
  @override
  ListResponse<T> build() => ListResponse(
        data: data,
      );
}
