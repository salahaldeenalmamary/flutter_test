import 'package:flutter/material.dart';
import '../../../theme/app_styles.dart';
class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
          top: 10, left: AppPaddings.screen),
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorTheme.primary
                      : ColorTheme.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  category,
                  style: FontTheme.body.copyWith(
                    color: isSelected
                        ? ColorTheme.textLight
                        : ColorTheme.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
