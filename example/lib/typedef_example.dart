import 'package:example/basic_example.dart' as be;
import 'package:mek_data_class/mek_data_class.dart';

part 'typedef_example.g.dart';

typedef JsonMap<T> = Map<String, T>;
typedef NullableJsonMap<T> = Map<String?, T>;

@DataClass(changeable: true, copyable: true)
class Extra with _$Extra {
  final JsonMap<int>? jsonMap;
  final NullableJsonMap<double?> nullableJsonMap;
  final be.Product product;
  final be.Product product2;

  const Extra({
    required this.jsonMap,
    required this.nullableJsonMap,
    required this.product,
    required this.product2,
  });
}
