import 'package:flutter/material.dart';
import '../../../theme/app_styles.dart';
class PaymentSummarySection extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;

  const PaymentSummarySection(
      {required this.subtotal, required this.deliveryFee});

  Widget _buildSummaryRow(String label, double amount,
      {bool isStrikethrough = false, double? originalAmount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: FontTheme.body.copyWith(color: ColorTheme.textPrimary)),
        Row(
          children: [
            if (isStrikethrough && originalAmount != null) ...[
              Text(
                '\$ ${originalAmount.toStringAsFixed(2)}',
                style: FontTheme.body.copyWith(
                  color: ColorTheme.textSecondary,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Gap.w8,
            ],
            Text('\$ ${amount.toStringAsFixed(2)}',
                style: FontTheme.body.copyWith(
                    color: ColorTheme.textPrimary,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.horizontalScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Summary', style: FontTheme.title),
          Gap.h16,
          _buildSummaryRow('Price', subtotal),
          Gap.h12,
          _buildSummaryRow('Delivery Fee', deliveryFee,
              isStrikethrough: deliveryFee < 2.0,
              originalAmount: 2.0), // Example discount
          Gap.h16,
          const Divider(color: ColorTheme.grey, height: 1),
          Gap.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Payment",
                  style:
                      FontTheme.body.copyWith(color: ColorTheme.textPrimary)),
              Text('\$ ${(subtotal + deliveryFee).toStringAsFixed(2)}',
                  style: FontTheme.title.copyWith(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}
