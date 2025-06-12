import 'package:flutter/material.dart';

import '../../../theme/app_styles.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home_filled, 'label': 'Home'},
      {'icon': Icons.favorite_border, 'label': 'Favorites'},
      {'icon': Icons.shopping_bag_outlined, 'label': 'Cart'},
      {'icon': Icons.notifications_none, 'label': 'Notifications'},
    ];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: ColorTheme.cardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = index == currentIndex;
          final item = items[index];
          return InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'] as IconData,
                  color: isSelected
                      ? ColorTheme.primary
                      : ColorTheme.textSecondary,
                  size: 28,
                ),
                if (isSelected) ...[
                  Gap.h4,
                  Container(
                    height: 5,
                    width: 5,
                    decoration: const BoxDecoration(
                      color: ColorTheme.primary,
                      shape: BoxShape.circle,
                    ),
                  )
                ]
              ],
            ),
          );
        }),
      ),
    );
  }
}
