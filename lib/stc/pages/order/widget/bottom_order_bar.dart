import 'package:flutter/material.dart';
import 'package:webapp/stc/core/extensions/navigation_extension.dart';

import '../../../router/route_manager.dart';
import '../../../theme/app_styles.dart';

class BottomOrderBar extends StatelessWidget {
  final double totalPrice;
  const BottomOrderBar({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppPaddings.screen, 16, AppPaddings.screen,
          AppPaddings.screen + MediaQuery.of(context).padding.bottom / 2),
      decoration: BoxDecoration(
        color: ColorTheme.cardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_wallet_outlined,
                  color: ColorTheme.primary, size: 28),
              Gap.w12,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cash/Wallet',
                        style: FontTheme.body
                            .copyWith(fontWeight: FontWeight.w600)),
                    Gap.h4,
                    Text('\$ ${totalPrice.toStringAsFixed(2)}',
                        style: FontTheme.subtitle.copyWith(
                            color: ColorTheme.primary,
                            fontWeight: FontWeight.w600)),

                    // For payment method selection
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.keyboard_arrow_down,
                    color: ColorTheme.textSecondary),
              ),
            ],
          ),
          Gap.h4,
          FilledButton(
            onPressed: () {
              context.pushNamed(
                RouteManager.deliveryRoute,
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: ColorTheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: FontTheme.title
                  .copyWith(color: ColorTheme.textLight, fontSize: 18),
            ),
            child: Text(
              'Order',
              style: FontTheme.title
                  .copyWith(color: ColorTheme.textLight, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
