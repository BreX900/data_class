import 'package:example/basic_example.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'typedef_example.g.dart';

typedef JsonMap<T> = Map<String, T>;
typedef NullableJsonMap<T> = Map<String, T>;

@DataClass(changeable: true, copyable: true, buildable: true)
@JsonSerializable(createToJson: false)
class Extra with _$Extra {
  final JsonMap<int>? jsonMap;
  final NullableJsonMap<double?> nullableJsonMap;
  final Product product;
  final Product product2;

  const Extra({
    required this.jsonMap,
    required this.nullableJsonMap,
    required this.product,
    required this.product2,
  });

  factory Extra.fromJson(Map<String, dynamic> map) => _$ExtraFromJson(map);
}
