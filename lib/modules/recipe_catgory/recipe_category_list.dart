import 'package:cook_with_me/core/model/recipe.dart';
import 'package:cook_with_me/core/provider/recipe_provider.dart';
import 'package:cook_with_me/modules/common/widgets/title.dart';
import 'package:cook_with_me/modules/recipe/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryListScreen extends ConsumerWidget {
  final String category;
  const CategoryListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes =
        ref.watch(recipeProvider.notifier).getRecipesByCategory(category);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          ScreenTitle(title: "Recipes for " + category),
          const SizedBox(height: 16),
          !recipes.isEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(recipes[index].name),
                        onTap: () {
                          // Action on tap (e.g., navigate to recipe detail)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RecipeScreen(recipeId: recipes[index].id)),
                          );
                        },
                      );
                    },
                  ),
                )
              : Center(
                  child: Text("Sorry, there is no recipes for this category!"),
                ),
        ],
      ),
    );
  }
}
