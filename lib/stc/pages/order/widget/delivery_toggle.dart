import 'package:flutter/material.dart';
import '../../../models/order.dart';
import '../../../theme/app_styles.dart';

class DeliveryToggle extends StatelessWidget {
  final DeliveryOption selectedOption;
  final ValueChanged<DeliveryOption> onOptionSelected;

  const DeliveryToggle({
    required this.selectedOption,
    required this.onOptionSelected,
  });

  Widget _buildOptionButton(
      BuildContext context, DeliveryOption option, String text) {
    final isSelected = selectedOption == option;
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth - AppPaddings.screen * 2 - 8) / 2;

    return GestureDetector(
      onTap: () => onOptionSelected(option),
      child: Container(
        width: buttonWidth,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
            color: isSelected ? ColorTheme.primary : ColorTheme.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? null : Border.all(color: ColorTheme.grey)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: FontTheme.body.copyWith(
            color: isSelected ? ColorTheme.textLight : ColorTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.horizontalScreen.copyWith(top: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: ColorTheme.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _buildOptionButton(context, DeliveryOption.deliver, 'Deliver')),
            Gap.w8,
            Expanded(child: _buildOptionButton(context, DeliveryOption.pickUp, 'Pick Up')),
          ],
        ),
      ),
    );
  }
}
