import 'package:flutter/material.dart';
import 'package:webapp/stc/util/image.dart';
import '../../../theme/app_styles.dart';
class DiscountSection extends StatelessWidget {
  const DiscountSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.horizontalScreen,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: ColorTheme.cardBackground,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: ColorTheme.grey),
          ),
          child: Row(
            children: [
               Image.asset(ImageConstants.discount_icon, color: ColorTheme.primary,),
              Gap.w12,
              Expanded(
                child: Text(
                  '1 Discount is Applied',
                  style: FontTheme.body.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 18, color: ColorTheme.textPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
