import 'package:cook_with_me/core/model/recipe_category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final RecipeCategory category;
  final double height;
  final double width;

  const CategoryCard(
      {Key? key, required this.category, this.height = 150, this.width = 300})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
