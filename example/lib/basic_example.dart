import 'package:collection/collection.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'basic_example.g.dart';

@DataClass(buildable: true, changeable: true)
class Order with _$Order {
  @DataField(equality: ProductEquality())
  final Product product;

  const Order({
    required this.product,
  });

  factory Order.build(void Function(OrderBuilder b) updates) =>
      (OrderBuilder()..update(updates)).build();
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

  const Product(
    this.id,
    this.title, {
    this.extraData,
  }) : idAndTitle = '$id - $title';
}

class ProductEquality implements Equality<Product> {
  const ProductEquality();

  @override
  bool equals(Product e1, Product e2) => e1.id == e2.id;

  @override
  int hash(Product e) => e.id.hashCode;

  @override
  bool isValidKey(Object? o) => throw UnimplementedError();
}

@DataClass(changeable: true)
class EmptyClass with _$EmptyClass {}
