import 'package:flutter/material.dart';
import '../../../models/coffee_model.dart';
import '../../../theme/app_styles.dart';

class OrderItem extends StatelessWidget {
  final Coffee coffee;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const OrderItem({
    required this.coffee,
    required this.quantity,
    required this.onQuantityChanged,
  });

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorTheme.grey),
        ),
        child: Icon(icon, size: 16, color: ColorTheme.textPrimary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.horizontalScreen,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              coffee.imageUrl,
              width: 54,
              height: 54,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : const Center(
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: ColorTheme.primary)));
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                    child: Icon(Icons.broken_image,
                        color: ColorTheme.grey, size: 24));
              },
            ),
          ),
          Gap.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coffee.name,
                    style: FontTheme.title.copyWith(fontSize: 16)),
                Gap.h4,
                Text(coffee.type, style: FontTheme.subtitle),
              ],
            ),
          ),
          Gap.w12,
          _buildQuantityButton(
              Icons.remove, () => onQuantityChanged(quantity - 1)),
          Gap.w12,
          Text(quantity.toString(),
              style: FontTheme.body
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 16)),
          Gap.w12,
          _buildQuantityButton(
              Icons.add, () => onQuantityChanged(quantity + 1)),
        ],
      ),
    );
  }
}
