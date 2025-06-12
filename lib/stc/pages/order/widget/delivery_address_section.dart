import 'package:flutter/material.dart';
import '../../../theme/app_styles.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection();

  Widget _buildActionButton(String label, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18, color: ColorTheme.textPrimary),
      label: Text(label,
          style: FontTheme.subtitle.copyWith(color: ColorTheme.textPrimary)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        side: const BorderSide(color: ColorTheme.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.horizontalScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery Address', style: FontTheme.title),
          Gap.h8,
          Text('Jl. Kpg Sutoyo',
              style: FontTheme.body.copyWith(fontWeight: FontWeight.w600)),
          Gap.h4,
          Text(
            'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
            style: FontTheme.subtitle,
          ),
          Gap.h12,
          Row(
            children: [
              _buildActionButton('Edit Address', Icons.edit_outlined),
              Gap.w12,
              _buildActionButton('Add Note', Icons.sticky_note_2_outlined),
            ],
          ),
        ],
      ),
    );
  }
}
