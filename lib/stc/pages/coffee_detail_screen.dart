
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webapp/stc/core/extensions/navigation_extension.dart';
import 'package:webapp/stc/pages/order/order_screen.dart';
import 'package:webapp/stc/util/image.dart';

import '../models/coffee_model.dart';
import '../router/route_manager.dart';
import '../theme/app_styles.dart'; 



class CoffeeDetailScreen extends HookWidget {
  final Coffee coffee;

  const CoffeeDetailScreen({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    final isFavorited = useState(false); 
    final selectedSize = useState('M'); 
    final isDescriptionExpanded = useState(false); 

    
    final String fullDescription =
        "A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the foamed milk on top should be between 1-2 cm thick. It is a classic coffee drink beloved for its rich flavor and velvety texture.";

    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: _DetailAppBar(
        isFavorited: isFavorited.value,
        onFavoriteToggle: () => isFavorited.value = !isFavorited.value,
      ),
      body: ListView(
        padding: AppPaddings.horizontalScreen,
        children: [
           Gap.h16,
          _CoffeeImage(imageUrl: coffee.imageUrl),
          Gap.h16,
          _CoffeeInfoSection(coffee: coffee),
          Gap.h16,
          const Divider(color: ColorTheme.grey, height: 1),
          Gap.h16,
          _DescriptionSection(
            description: fullDescription,
            isExpanded: isDescriptionExpanded.value,
            onToggleExpand: () => isDescriptionExpanded.value = !isDescriptionExpanded.value,
          ),
          Gap.h16,
          _SizeSelectionSection(
            selectedSize: selectedSize.value,
            onSizeSelected: (size) => selectedSize.value = size,
          ),
          Gap.h24, 
        ],
      ),
      bottomNavigationBar: _BottomBuyBar(price: coffee.price, orderItem: coffee,),
    );
  }
}



class _DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;

  const _DetailAppBar({required this.isFavorited, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorTheme.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: ColorTheme.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text('Detail', style: FontTheme.title.copyWith(color: ColorTheme.textPrimary)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited ? ColorTheme.promoTag : ColorTheme.textPrimary,
            size: 28,
          ),
          onPressed: onFavoriteToggle,
        ),
        Gap.w8,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CoffeeImage extends StatelessWidget {
  final String imageUrl;
  const _CoffeeImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10, 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            return progress == null ? child : const Center(child: CircularProgressIndicator(color: ColorTheme.primary));
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.broken_image, color: ColorTheme.grey, size: 50));
          },
        ),
      ),
    );
  }
}

class _CoffeeInfoSection extends StatelessWidget {
  final Coffee coffee;
  const _CoffeeInfoSection({required this.coffee});

  Widget _buildInfoIcon(IconData iconData) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorTheme.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(iconData, color: ColorTheme.primary, size: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(coffee.name, style: FontTheme.heading2.copyWith(fontSize: 22)),
        Gap.h4,
        Text("Ice/Hot", style: FontTheme.subtitle.copyWith(fontSize: 13)), 
        Gap.h12,
        Row(
          children: [
            const Icon(Icons.star, color: ColorTheme.star, size: 24),
            Gap.w4,
            Text(coffee.rating.toString(), style: FontTheme.title.copyWith(fontSize: 17)),
            Gap.w4,
            Text('(230)', style: FontTheme.subtitle.copyWith(fontSize: 13)), 
            const Spacer(),
            Image.asset(ImageConstants.mask_Group),
            Gap.w12,
            _buildInfoIcon(Icons.coffee_outlined), 
            Gap.w12,
            _buildInfoIcon(Icons.water_drop_outlined), 
          ],
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onToggleExpand;

  const _DescriptionSection({
    required this.description,
    required this.isExpanded,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    final displayDescription = isExpanded
        ? description
        : (description.length > 150 ? '${description.substring(0, 150)}...' : description);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: FontTheme.title),
        Gap.h8,
        GestureDetector(
          onTap: description.length > 150 ? onToggleExpand : null,
          child: RichText(
            text: TextSpan(
              style: FontTheme.body.copyWith(color: ColorTheme.textSecondary, height: 1.5),
              children: [
                TextSpan(text: displayDescription),
                if (description.length > 150)
                  TextSpan(
                    text: isExpanded ? ' Read Less' : ' Read More',
                    style: FontTheme.body.copyWith(color: ColorTheme.primary, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SizeSelectionSection extends StatelessWidget {
  final String selectedSize;
  final ValueChanged<String> onSizeSelected;
  final List<String> sizes = const ['S', 'M', 'L'];

  const _SizeSelectionSection({
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size', style: FontTheme.title),
        Gap.h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: sizes.map((size) {
            final isSelected = size == selectedSize;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: size == sizes.last ? 0 : 8.0),
                child: OutlinedButton(
                  onPressed: () => onSizeSelected(size),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: isSelected ? ColorTheme.primary.withOpacity(0.1) : ColorTheme.cardBackground,
                    side: BorderSide(
                      color: isSelected ? ColorTheme.primary : ColorTheme.grey,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    size,
                    style: FontTheme.body.copyWith(
                      color: isSelected ? ColorTheme.primary : ColorTheme.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _BottomBuyBar extends StatelessWidget {
  final double price;
  final Coffee orderItem;
  const _BottomBuyBar({required this.price,required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppPaddings.screen, 16, AppPaddings.screen, AppPaddings.screen + MediaQuery.of(context).padding.bottom / 2),
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
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price', style: FontTheme.subtitle.copyWith(fontSize: 13)),
              Gap.h4,
              Text('\$ ${price.toStringAsFixed(2)}', style: FontTheme.title.copyWith(color: ColorTheme.primary, fontSize: 20)),
            ],
          ),
          Gap.w16,
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                  context.pushNamed(RouteManager.orderRoute,
                 arguments: orderItem);
                  
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: FontTheme.title.copyWith(color: ColorTheme.textLight, fontSize: 18),
              ),
              child:  Text('Buy Now', style: FontTheme.title.copyWith(color: ColorTheme.textLight, fontSize: 18),),
            ),
          ),
        ],
      ),
    );
  }
}