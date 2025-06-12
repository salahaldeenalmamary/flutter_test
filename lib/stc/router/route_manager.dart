import 'package:flutter/material.dart';

import '../models/coffee_model.dart';
import '../pages/coffee_detail_screen.dart';
import '../pages/delivery_screen.dart';
import '../pages/home/home_screen.dart';
import '../pages/onboarding_screen.dart';
import '../pages/order/order_screen.dart';

class RouteManager {
  static const String onboardingRoute = '/';
  static const String homeRoute = '/home';
  static const String coffeeDetailRoute = '/coffeeDetail';
  static const String orderRoute = '/order';
  static const String deliveryRoute = '/delivery';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case deliveryRoute:
        return MaterialPageRoute(builder: (_) => const DeliveryScreen());

      case coffeeDetailRoute:
        final coffee = settings.arguments as Coffee;
        return MaterialPageRoute(
          builder: (_) => CoffeeDetailScreen(coffee: coffee),
        );

      case orderRoute:
        final orderItem = settings.arguments as Coffee;
        return MaterialPageRoute(
          builder: (_) => OrderScreen(orderItem: orderItem),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
