import 'package:collection/collection.dart';

class $NullableEquality<T extends Object> implements Equality<T?> {
  final Equality<T> base;

  const $NullableEquality(this.base);

  @override
  bool equals(T? e1, T? e2) =>
      (e1 != null && e2 != null && base.equals(e1, e2)) || e1 == null && e2 == null;

  @override
  int hash(T? e) => e != null ? base.hash(e) : e.hashCode;

  @override
  bool isValidKey(Object? o) => o == null || base.isValidKey(o);
}
