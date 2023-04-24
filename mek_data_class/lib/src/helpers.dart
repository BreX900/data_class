import 'package:collection/collection.dart';
import 'package:mek_data_class/src/data_collection_equality.dart';

/// For use by generated code in equal operator. Do not use directly.
const Equality<List<Object?>?> $listEquality = ListEquality($CollectionEquality());

/// For use by generated code in equal operator. Do not use directly.
const Equality<Set<Object?>?> $setEquality = SetEquality($CollectionEquality());

/// For use by generated code in equal operator. Do not use directly.
const Equality<Map<Object?, Object?>?> $mapEquality =
    MapEquality(keys: $CollectionEquality(), values: $CollectionEquality());

typedef $MultiEquality<E> = MultiEquality<E>;

/// For use by generated code in calculating hash codes. Do not use directly.
int $hashCombine(int hash, int value) {
  hash = 0x1fffffff & (hash + value);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

/// For use by generated code in calculating hash codes. Do not use directly.
int $hashFinish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}
