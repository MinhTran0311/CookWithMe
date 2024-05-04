import 'package:cook_with_me/core/enums/bottom_nav_item.dart';
import 'package:cook_with_me/modules/config/custom_router.dart';
import 'package:cook_with_me/modules/home/home_screen.dart';
import 'package:cook_with_me/modules/recipe/recipe_screen.dart';
import 'package:cook_with_me/modules/recipe_catgory/recipe_category.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  const TabNavigator({Key? key, required this.navigatorKey, required this.item})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
              settings: const RouteSettings(name: tabNavigatorRoot),
              builder: (context) => routeBuilders[initialRoute]!(context))
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilder() {
    return {tabNavigatorRoot: (context) => _getScren(context, item)};
  }

  _getScren(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.one:
        return const RecipeScreen();
      case BottomNavItem.two:
        return HomeScreen();
      case BottomNavItem.three:
        return const RecipeCategoryScreen();
      default:
        return const Scaffold();
    }
  }
}
