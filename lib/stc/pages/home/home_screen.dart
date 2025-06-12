import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webapp/stc/core/extensions/navigation_extension.dart';
import '../../models/coffee_model.dart';
import '../../theme/app_styles.dart';
import 'widget/bottom_nav_bar.dart';
import 'widget/category_tabs.dart';
import 'widget/promo_banner.dart';
import 'widget/sliver_category_header_delegate.dart';
import 'widget/sliver_coffee_grid.dart';
import 'widget/sliver_home_header_delegate.dart';


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
        SliverPersistentHeader(
          delegate: SliverHomeHeaderDelegate(
            searchController: searchController,
            topPadding: MediaQuery.of(context).padding.top,
          ),
          pinned: true,
        ),
          const SliverToBoxAdapter(child: PromoBanner()),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverCategoryHeaderDelegate(
              child: CategoryTabs(
                categories: categories,
                selectedCategory: selectedCategory.value,
                onCategorySelected: (category) =>
                    selectedCategory.value = category,
              ),
            ),
          ),
          SliverPadding(
            padding: AppPaddings.allScreen.copyWith(top: 16),
            sliver: SliverCoffeeGrid(coffeeList: coffeeList),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: bottomNavIndex.value,
        onTap: (index) => bottomNavIndex.value = index,
      ),
    );
  }
}
