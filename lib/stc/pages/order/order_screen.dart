import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webapp/stc/core/extensions/navigation_extension.dart';
import '../../models/delivery_details.dart';
import './widget/bottom_order_bar.dart';
import './widget/delivery_address_section.dart';
import './widget/delivery_toggle.dart';
import './widget/discount_section.dart';
import './widget/order_app_bar.dart';
import './widget/order_item.dart';
import './widget/payment_summary_section.dart';
import '../../models/coffee_model.dart';
import '../../models/order.dart';
import '../../theme/app_styles.dart';

class OrderScreen extends HookWidget {
  final Coffee orderItem;

  const OrderScreen({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    final order = useState(Order(item: orderItem));
 final deliveryDetails = useState(DeliveryDetails(
      street: 'Jl. Kpg Sutoyo',
      details: 'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
      note: null,
    ));
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: OrderAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          DeliveryToggle(
            selectedOption: order.value.deliveryOption,
            onOptionSelected: (option) {
             order.value = order.value.copyWith(deliveryOption: option);

            },
          ),
          Gap.h24,
          if (order.value.isDeliver) ...[
            DeliveryAddressSection(  initialDetails: deliveryDetails.value, 
                onSave: (updatedDetails) {
                 
                  deliveryDetails.value = updatedDetails;
                },),
            Gap.h24,
          ],
          OrderItem(
            coffee: order.value.item,
            quantity: order.value.quantity,
            onQuantityChanged: (newQuantity) {
              if (newQuantity >= 1) {
               order.value = order.value.copyWith(quantity: newQuantity);

              }
            },
          ),
          const Divider(height: 32, thickness: 1, color: ColorTheme.grey),
          const DiscountSection(),
          Gap.h24,
          PaymentSummarySection(
            subtotal: order.value.subtotal,
            deliveryFee: order.value.isDeliver ? order.value.deliveryFee : 0.0,
          ),
        ],
      ),
      bottomNavigationBar: BottomOrderBar(totalPrice: order.value.total),
    );
  }
}
