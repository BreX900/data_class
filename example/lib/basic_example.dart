import 'package:mek_data_class/mek_data_class.dart';

part 'basic_example.g.dart';

@DataClass()
class Product with _$Product {
  final int id;
  final String? title;
  final Map<String, int?>? extraData;

  const Product({
    required this.id,
    required this.title,
    this.extraData,
  });
}
