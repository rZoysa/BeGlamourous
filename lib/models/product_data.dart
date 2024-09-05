class Product {
  final String productId;
  final String name;
  final String description;
  final String brand;
  final List<String> sideEffects;
  final List<String> suitableSkinType;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.brand,
    required this.sideEffects,
    required this.suitableSkinType,
  });
}
