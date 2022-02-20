class Product {
  final String field;

  const Product({
    required this.field,
  });

  Product change(void Function(ProductChanges) updates) {
    final changes = ProductChanges(this);
    updates(changes);
    return changes.build();
  }

  ProductChanges toChanges() => ProductChanges(this);
}

class ProductChanges {
  String field;

  ProductChanges(Product product) : field = product.field;

  Product build() => Product(
        field: field,
      );
}
