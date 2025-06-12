import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webapp/stc/core/extensions/navigation_extension.dart';
import '../models/coffee_model.dart';
import '../models/order.dart';
import '../router/route_manager.dart';
import '../theme/app_styles.dart';


class OrderScreen extends HookWidget {
  final Coffee orderItem;

  const OrderScreen({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    final order = useState(Order(item: orderItem));

    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: _OrderAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          _DeliveryToggle(
            selectedOption: order.value.deliveryOption,
            onOptionSelected: (option) {
              order.value = Order(
                item: order.value.item,
                quantity: order.value.quantity,
                deliveryOption: option,
                deliveryFee: order.value.deliveryFee,
                discount: order.value.discount,
              );
            },
          ),
          Gap.h24,
          if (order.value.isDeliver) ...[
            _DeliveryAddressSection(),
            Gap.h24,
          ],
          _OrderItem(
            coffee: order.value.item,
            quantity: order.value.quantity,
            onQuantityChanged: (newQuantity) {
              if (newQuantity >= 1) {
                order.value = Order(
                  item: order.value.item,
                  quantity: newQuantity,
                  deliveryOption: order.value.deliveryOption,
                  deliveryFee: order.value.deliveryFee,
                  discount: order.value.discount,
                );
              }
            },
          ),
          const Divider(height: 32, thickness: 1, color: ColorTheme.grey),
          const _DiscountSection(),
          Gap.h24,
          _PaymentSummarySection(
            subtotal: order.value.subtotal,
            deliveryFee: order.value.isDeliver ? order.value.deliveryFee : 0.0,
          ),
        ],
      ),
      bottomNavigationBar: _BottomOrderBar(totalPrice: order.value.total),
    );
  }
}

class _OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _OrderAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorTheme.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: ColorTheme.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text('Order',
          style: FontTheme.title.copyWith(color: ColorTheme.textPrimary)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DeliveryToggle extends StatelessWidget {
  final DeliveryOption selectedOption;
  final ValueChanged<DeliveryOption> onOptionSelected;

  const _DeliveryToggle({
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

class _DeliveryAddressSection extends StatelessWidget {
  const _DeliveryAddressSection();

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

class _OrderItem extends StatelessWidget {
  final Coffee coffee;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const _OrderItem({
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

class _DiscountSection extends StatelessWidget {
  const _DiscountSection();

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
              const Icon(Icons.sell_outlined,
                  color: ColorTheme.primary), // Placeholder discount icon
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

class _PaymentSummarySection extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;

  const _PaymentSummarySection(
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

class _BottomOrderBar extends StatelessWidget {
  final double totalPrice;
  const _BottomOrderBar({required this.totalPrice});

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
      child: Row(
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
                    style:
                        FontTheme.body.copyWith(fontWeight: FontWeight.w600)),
                Gap.h4,
                Text('\$ ${totalPrice.toStringAsFixed(2)}',
                    style: FontTheme.subtitle.copyWith(
                        color: ColorTheme.primary,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down,
              color: ColorTheme.textSecondary), // For payment method selection
          Gap.w16,
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(
                  RouteManager.deliveryRoute,
                );
              },
              style: ElevatedButton.styleFrom(
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
          ),
        ],
      ),
    );
  }
}
