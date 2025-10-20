// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Response<T> {
  Response<T> copyWith({$Parameter<T> data = const Unspecified()});
  Response<T> change(void Function(ResponseChanges<T> c) updates);
  ResponseChanges<T> toChanges();
}

abstract class ResponseChanges<T> {
  ResponseChanges._(this._original);

  final Response<T> _original;

  late T data = _original.data;

  void update(void Function(ResponseChanges<T> c) updates);
  Response<T> build();
}

mixin _$PaginatedResponse<T extends Object> {
  PaginatedResponse<T> get _self => this as PaginatedResponse<T>;
  PaginatedResponse<T> copyWith({
    $Parameter<T> data = const Unspecified(),
    $Parameter<int> total = const Unspecified(),
  }) {
    return PaginatedResponse(
      data: Unspecified.resolve(_self.data, data),
      total: Unspecified.resolve(_self.total, total),
    );
  }

  PaginatedResponse<T> change(
          void Function(PaginatedResponseChanges<T> c) updates) =>
      (toChanges()..update(updates)).build();
  PaginatedResponseChanges<T> toChanges() => PaginatedResponseChanges._(_self);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginatedResponse<T> &&
          runtimeType == other.runtimeType &&
          _self.total == other.total &&
          _self.data == other.data;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.total.hashCode);
    hashCode = $hashCombine(hashCode, _self.data.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('PaginatedResponse', [T])
        ..add('total', _self.total)
        ..add('data', _self.data))
      .toString();
}

class PaginatedResponseChanges<T extends Object> implements ResponseChanges<T> {
  PaginatedResponseChanges._(this._original);

  @override
  final PaginatedResponse<T> _original;

  @override
  late T data = _original.data;

  late int total = _original.total;

  @override
  void update(void Function(PaginatedResponseChanges<T> c) updates) =>
      updates(this);

  @override
  PaginatedResponse<T> build() {
    return PaginatedResponse(
      data: data,
      total: total,
    );
  }
}

mixin _$ListResponse<T> {
  ListResponse<T> get _self => this as ListResponse<T>;
  ListResponse<T> copyWith({$Parameter<List<T>> data = const Unspecified()}) {
    return ListResponse(
      data: Unspecified.resolve(_self.data, data),
    );
  }

  ListResponse<T> change(void Function(ListResponseChanges<T> c) updates) =>
      (toChanges()..update(updates)).build();
  ListResponseChanges<T> toChanges() => ListResponseChanges._(_self);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListResponse<T> &&
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
      (ClassToString('ListResponse', [T])..add('data', _self.data)).toString();
}

class ListResponseChanges<T> implements ResponseChanges<List<T>> {
  ListResponseChanges._(this._original);

  @override
  final ListResponse<T> _original;

  @override
  late List<T> data = _original.data;

  @override
  void update(void Function(ListResponseChanges<T> c) updates) => updates(this);

  @override
  ListResponse<T> build() {
    return ListResponse(
      data: data,
    );
  }
}
