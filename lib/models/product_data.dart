import 'dart:convert';

class Product {
  final String name;
  final String description;
  final String brand;
  final List<String> sideEffects;

  Product({
    required this.name,
    required this.description,
    required this.brand,
    required this.sideEffects,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['Name'],
      description: json['Description'],
      brand: json['Brand'],
      sideEffects: json['SideEffects'] != null
          ? List<String>.from(jsonDecode(json['SideEffects']))
          : [],
    );
  }
}
