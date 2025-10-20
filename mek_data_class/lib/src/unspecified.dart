import 'dart:async';

import 'package:meta/meta.dart';

typedef $Parameter<T> = FutureOr<T>;

@optionalTypeArgs
final class Unspecified<T> implements Future<T> {
  @literal
  const Unspecified();

  static R resolve<R>(R current, FutureOr<R> next) {
    assert(next is R || next is Unspecified<R>);
    return next is R ? next : current;
  }

  @override
  Stream<T> asStream() => throw UnimplementedError();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      throw UnimplementedError();

  @override
  Future<R> then<R>(FutureOr<R> Function(T value) onValue, {Function? onError}) =>
      throw UnimplementedError();

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      throw UnimplementedError();

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) => throw UnimplementedError();
}
