import 'package:flutter/material.dart';
import 'package:webapp/stc/core/extensions/navigation_extension.dart';
import '../../../models/coffee_model.dart';
import '../../../router/route_manager.dart';
import 'coffee_card.dart';

class SliverCoffeeGrid extends StatelessWidget {
  const SliverCoffeeGrid({required this.coffeeList});
  final List<Coffee> coffeeList;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
  
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
              child: CoffeeCard(coffee: coffeeList[index]),
              onTap: () {
                context.pushNamed(RouteManager.coffeeDetailRoute,
                 arguments: coffeeList[index]);
              
              });
        });
  }
}
