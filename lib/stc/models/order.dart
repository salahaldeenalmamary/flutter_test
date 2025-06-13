import 'package:webapp/stc/models/coffee_model.dart';

enum DeliveryOption { deliver, pickUp }
class Order {
  final Coffee item;
  final int quantity;
  final DeliveryOption deliveryOption;
  final double deliveryFee;
  final double discount;

  Order({
    required this.item,
    this.quantity = 1,
    this.deliveryOption = DeliveryOption.deliver,
    this.deliveryFee = 1.0,
    this.discount = 0.0,
  });

  Order copyWith({
    Coffee? item,
    int? quantity,
    DeliveryOption? deliveryOption,
    double? deliveryFee,
    double? discount,
  }) {
    return Order(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      deliveryOption: deliveryOption ?? this.deliveryOption,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
    );
  }

  double get subtotal => item.price * quantity;

  double get total {
    final fee = deliveryOption == DeliveryOption.deliver ? deliveryFee : 0;
    return subtotal + fee - discount;
  }

  bool get isDeliver => deliveryOption == DeliveryOption.deliver;
}
