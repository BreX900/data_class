import 'package:collection/collection.dart';

class $CollectionEquality implements Equality<Object?> {
  final Equality<dynamic> base;

  const $CollectionEquality([this.base = const DefaultEquality<Never>()]);

  @override
  bool equals(Object? e1, Object? e2) {
    if (e1 is List) return e2 is List && ListEquality(this).equals(e1, e2);
    if (e1 is Map) return e2 is Map && MapEquality(keys: this, values: this).equals(e1, e2);
    if (e1 is Set) return e2 is Set && SetEquality(this).equals(e1, e2);
    return base.equals(e1, e2);
  }

  @override
  int hash(Object? o) {
    if (o is List) return ListEquality(this).hash(o);
    if (o is Map) return MapEquality(keys: this, values: this).hash(o);
    if (o is Set) return SetEquality(this).hash(o);
    return base.hash(o);
  }

  @override
  bool isValidKey(Object? o) => true;
}
