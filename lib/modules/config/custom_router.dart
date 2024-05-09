import 'package:cook_with_me/modules/config/home_page.dart';
import 'package:cook_with_me/modules/config/route_paths.dart';
import 'package:cook_with_me/modules/recipe/recipe_screen.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case RoutePaths.Random:
        return MaterialPageRoute(
            builder: (context) => const RecipeScreen(isRandomRecipe: true),
            settings: RouteSettings(
                name: RoutePaths.Random, arguments: settings.arguments));

      case RoutePaths.Home:
        return MaterialPageRoute(
            builder: (context) => HomePage(),
            settings: const RouteSettings(name: RoutePaths.Home));

      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRoute(RouteSettings settings) {
    print('Nested Route: ${settings.name}');
    // this is where you define the nested routes.
    switch (settings.name) {
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong'),
        ),
      ),
    );
  }
}
