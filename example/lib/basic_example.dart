import 'package:collection/collection.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'basic_example.g.dart';

@DataClass(buildable: true, changeable: true)
class Order with _$Order {
  @DataField(equality: ProductEquality())
  final Product product;
  final bool isSent;
  final bool? isNew;

  Order({required this.product, required bool? isSent, required this.isNew})
    : isSent = isSent ?? false;

  bool get isSentAndNew => isSent && (isNew ?? true);
  late final bool isSentOrNew = isSent || (isNew ?? true);

  factory Order.build(void Function(OrderBuilder b) updates) =>
      (OrderBuilder()..update(updates)).build();
}

@DataClass(changeable: true, copyable: true)
class Product with _$Product {
  @DataField(equatable: false)
  final int id;
  final String? title;
  @DataField(stringify: false)
  final Map<String, int?>? extraData;

  final String idAndTitle;

  const Product(this.id, @DataParameter(updatable: false) this.title, {this.extraData})
    : idAndTitle = '$id - $title';

  factory Product.fromJson(Map<String, dynamic> map) => Object() as Product;
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

@DataClass(buildable: true, copyable: true, mergeable: true, changeable: true)
class EmptyClass with _$EmptyClass {
  const EmptyClass._();
}
