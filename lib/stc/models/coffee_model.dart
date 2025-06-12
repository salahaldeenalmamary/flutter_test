// lib/models/coffee_model.dart
class Coffee {
  final String name;
  final String type;
  final double price;
  final double rating;
  final String imageUrl;

  Coffee({
    required this.name,
    required this.type,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}