import 'package:collection/collection.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'equality_example.g.dart';

@CustomDataClass()
class Order with _$Order {
  final Product product;
  final Product? freeProduct;

  const Order({required this.product, required this.freeProduct});
}

@CustomDataClass()
class Category with _$Category {
  final List<Product> products;
  final List<Product?> freeProducts;

  const Category({required this.products, required this.freeProducts});
}

@CustomDataClass()
class Product with _$Product {
  final int id;

  const Product({required this.id});
}

class ProductEquality implements Equality<Product> {
  const ProductEquality();

  @override
  bool equals(Product e1, Product e2) => e1.id == e2.id;

  @override
  int hash(Product e) => e.id.hashCode;

  @override
  bool isValidKey(Object? o) => o is Product;
}

class CustomDataClass extends DataClass {
  const CustomDataClass() : super(equalities: const [ProductEquality()]);
}
