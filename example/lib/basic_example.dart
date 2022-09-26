import 'package:mek_data_class/mek_data_class.dart';

part 'basic_example.g.dart';

@DataClass(createFieldsClass: true)
class Order with _$Order {
  final Product product;

  static final OrderFields fields = OrderFields();

  const Order({
    required this.product,
  });
}

@DataClass(createFieldsClass: true)
class Product with _$Product {
  final int id;
  final String? title;
  final Map<String, int?>? extraData;

  static final ProductFields fields = ProductFields();

  const Product({
    required this.id,
    required this.title,
    this.extraData,
  });
}
