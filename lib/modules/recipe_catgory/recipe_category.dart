import 'package:cook_with_me/core/constants/breakpoints.dart';
import 'package:cook_with_me/core/provider/recipe_category_provider.dart';
import 'package:cook_with_me/modules/common/widgets/category_card.dart';
import 'package:cook_with_me/modules/common/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeCategoryScreen extends StatelessWidget {
  const RecipeCategoryScreen();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            ScreenTitle(title: "Recipe Categories"),
            SizedBox(
              height: 16,
            ),
            Expanded(child: CategoryListWidget()),
          ],
        );
      }),
    );
  }
}

class CategoryListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(recipeCategoryProvider);

    int count = MediaQuery.of(context).size.width ~/ 250;
    count = count < 1 ? 1 : count;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count, // Responsive grid based on screen width
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2, // Aspect ratio of each grid item
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }
}
