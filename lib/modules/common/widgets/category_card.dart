import 'package:cook_with_me/core/model/recipe_category.dart';
import 'package:cook_with_me/modules/recipe/recipe_screen.dart';
import 'package:cook_with_me/modules/recipe_catgory/recipe_category.dart';
import 'package:cook_with_me/modules/recipe_catgory/recipe_category_list.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final RecipeCategory category;
  final double height;
  final double width;

  const CategoryCard(
      {Key? key, required this.category, this.height = 200, this.width = 300})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryListScreen(category: category.name)));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Placeholder(
                fallbackHeight: height,
                fallbackWidth: width,
              ), // Image placeholder
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    overflow: TextOverflow.clip),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
