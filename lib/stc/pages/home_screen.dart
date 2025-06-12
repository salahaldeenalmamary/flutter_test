import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/coffee_model.dart';
import '../theme/app_styles.dart';
import 'coffee_detail_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final categories =
        useMemoized(() => ['All Coffee', 'Machiato', 'Latte', 'Americano']);
    final selectedCategory = useState(categories.first);
    final bottomNavIndex = useState(0);

    final coffeeList = useMemoized(() => [
          Coffee(
              name: 'Caffe Mocha',
              type: 'Deep Foam',
              price: 4.53,
              rating: 4.8,
              imageUrl:
                  'https://cdn.pixabay.com/photo/2017/09/04/18/39/coffee-2714970_1280.jpg'),
          Coffee(
              name: 'Cappuccino',
              type: 'Steamed Milk',
              price: 5.10,
              rating: 4.9,
              imageUrl:
                  'https://cdn.pixabay.com/photo/2017/09/04/18/39/coffee-2714970_1280.jpg'),
          Coffee(
              name: 'Latte',
              type: 'Espresso',
              price: 4.80,
              rating: 4.7,
              imageUrl:
                  'https://cdn.pixabay.com/photo/2017/09/04/18/39/coffee-2714970_1280.jpg')
        ]);

    return Scaffold(
      backgroundColor: ColorTheme.background,
      body: CustomScrollView(
        slivers: [
          _SliverHomeHeader(searchController: searchController),
          const SliverToBoxAdapter(child: _PromoBanner()),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverCategoryHeaderDelegate(
              child: _CategoryTabs(
                categories: categories,
                selectedCategory: selectedCategory.value,
                onCategorySelected: (category) =>
                    selectedCategory.value = category,
              ),
            ),
          ),
          SliverPadding(
            padding: AppPaddings.allScreen.copyWith(top: 16),
            sliver: _SliverCoffeeGrid(coffeeList: coffeeList),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(
        currentIndex: bottomNavIndex.value,
        onTap: (index) => bottomNavIndex.value = index,
      ),
    );
  }
}

// Delegate for the sticky category tabs header
class _SliverCategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverCategoryHeaderDelegate({required this.child});

  // Height of the category tabs section
  final double _height = 50.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: ColorTheme.background,
      child: child,
    );
  }

  @override
  double get maxExtent => _height;

  @override
  double get minExtent => _height;

  @override
  bool shouldRebuild(covariant _SliverCategoryHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}

// Private Sub-Widgets (Refactored for Slivers)

class _SliverHomeHeader extends StatelessWidget {
  const _SliverHomeHeader({required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    // Calculate expanded height based on content + paddings
    final double expandedHeight = topPadding + 160;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.fromLTRB(AppPaddings.screen, topPadding,
              AppPaddings.screen, AppPaddings.screen / 2),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF131313), Color(0xFF313131)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location',
                  style: FontTheme.subtitle
                      .copyWith(color: ColorTheme.textSecondary)),
              Gap.h4,
              Row(
                children: [
                  Text('Bilzen, Tanjungbalai',
                      style: FontTheme.body.copyWith(
                          color: ColorTheme.textLight,
                          fontWeight: FontWeight.w600)),
                  Gap.w4,
                  const Icon(Icons.keyboard_arrow_down,
                      color: ColorTheme.textLight, size: 20),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style:
                          FontTheme.body.copyWith(color: ColorTheme.textLight),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        hintText: 'Search coffee',
                        hintStyle: FontTheme.body
                            .copyWith(color: ColorTheme.textSecondary),
                        prefixIcon: const Icon(Icons.search,
                            color: ColorTheme.textLight),
                        filled: true,
                        fillColor: const Color(0xFF313131),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Gap.w12,
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorTheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverCoffeeGrid extends StatelessWidget {
  const _SliverCoffeeGrid({required this.coffeeList});
  final List<Coffee> coffeeList;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Responsive aspect ratio based on card size
    final childAspectRatio = (screenWidth / 2 - 32) / 250;

    return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: coffeeList.length,
        itemBuilder: (context, index) {
          return InkWell(
              child: _CoffeeCard(coffee: coffeeList[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CoffeeDetailScreen(coffee: coffeeList[index]),
                  ),
                );
              });
        });
  }
}

// Unchanged Sub-Widgets (Promo, Tabs, Card, Nav)

class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppPaddings.screen, 24, AppPaddings.screen, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              color: const Color(0xFF313131),
            ),
            Positioned.fill(
              child: Image.network(
                'https://cdn.pixabay.com/photo/2017/09/04/18/39/coffee-2714970_1280.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: ColorTheme.promoTag,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Promo',
                        style: FontTheme.body.copyWith(
                            color: ColorTheme.textLight,
                            fontWeight: FontWeight.w600)),
                  ),
                  Gap.h8,
                  Text(
                    'Buy one get\none FREE',
                    style: FontTheme.heading1
                        .copyWith(color: ColorTheme.textLight, height: 1.1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs({
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
          top: 10, left: AppPaddings.screen), // Adjusted padding
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

class _CoffeeCard extends StatelessWidget {
  const _CoffeeCard({required this.coffee});
  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    coffee.imageUrl,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // Add loading and error builders for better UX
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(
                              child: CircularProgressIndicator(
                                  color: ColorTheme.primary));
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                          child:
                              Icon(Icons.broken_image, color: ColorTheme.grey));
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star,
                            color: ColorTheme.star, size: 16),
                        Gap.w4,
                        Text(
                          coffee.rating.toString(),
                          style: FontTheme.subtitle.copyWith(
                              color: ColorTheme.textLight,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coffee.name,
                    style: FontTheme.title.copyWith(fontSize: 16)),
                Gap.h4,
                Text(coffee.type, style: FontTheme.subtitle),
                Gap.h12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$ ${coffee.price.toStringAsFixed(2)}',
                        style: FontTheme.title
                            .copyWith(color: ColorTheme.textPrimary)),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorTheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 28),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentIndex, required this.onTap});
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
