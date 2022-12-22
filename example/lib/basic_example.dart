import 'package:mek_data_class/mek_data_class.dart';

part 'basic_example.g.dart';

@DataClass(changeable: true)
class Order with _$Order {
  final Product product;

  const Order({
    required this.product,
  });
}

@DataClass(changeable: true, copyable: true)
class Product with _$Product {
  @DataField(comparable: false)
  final int id;
  @DataField(updatable: false)
  final String? title;
  @DataField(stringify: false)
  final Map<String, int?>? extraData;

  final String idAndTitle;

  const Product({
    required this.id,
    required this.title,
    this.extraData,
  }) : idAndTitle = '$id - $title';
}
