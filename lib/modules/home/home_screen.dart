import 'dart:math';

import 'package:cook_with_me/core/constants/breakpoints.dart';
import 'package:cook_with_me/core/constants/globals.dart';
import 'package:cook_with_me/core/model/recipe.dart';
import 'package:cook_with_me/core/model/recipe_category.dart';
import 'package:cook_with_me/core/provider/recipe_category_provider.dart';
import 'package:cook_with_me/core/provider/recipe_provider.dart';
import 'package:cook_with_me/modules/common/widgets/category_card.dart';
import 'package:cook_with_me/modules/common/widgets/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeProvider);
    final recipeOfTheday = (recipes.isEmpty
        ? null
        : recipes.elementAtOrNull(
            Random().nextInt(ref.watch(recipeProvider).length)));
    final category = ref.watch(recipeCategoryProvider).take(5).toList();

    return recipeOfTheday == null || category.firstOrNull == null
        ? Center(child: const CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < Breakpoints.sm) {
                return _buildMobileLayout(context, category, recipeOfTheday);
              } else if (constraints.maxWidth < Breakpoints.lg) {
                return _buildTabletLayout(context, category, recipeOfTheday);
              } else {
                return _buildDesktopLayout(context, category, recipeOfTheday);
              }
            }),
          );
  }

  Widget _buildMobileLayout(BuildContext context, List<RecipeCategory> category,
      Recipe recipeOfTheChef) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ScreenTitle(title: "Homepage"),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  margin: EdgeInsets.only(right: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ScreenTitle(title: "Recipe of the chef"),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.all(16),
                                    child: const Placeholder(
                                      fallbackHeight: 200,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          'Ingredients:',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        _buildIngredients(
                                            recipeOfTheChef.ingredients),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              color: Colors.grey[200],
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Steps:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildSteps(recipeOfTheChef.steps)
                                ],
                              ),
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          _buildCategoryList(context, category, layout: 3),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, List<RecipeCategory> category,
      Recipe recipeOfTheChef) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ScreenTitle(title: "Homepage"),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  margin: EdgeInsets.only(right: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ScreenTitle(title: "Recipe of the chef"),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.all(16),
                                    child: const Placeholder(
                                      fallbackHeight: 200,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          'Ingredients:',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        _buildIngredients(
                                            recipeOfTheChef.ingredients),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          'Steps:',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        _buildSteps(recipeOfTheChef.steps)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          _buildCategoryList(context, category, layout: 2),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context,
      List<RecipeCategory> category, Recipe recipeOfTheChef) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ScreenTitle(title: "Homepage"),
          SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  margin: EdgeInsets.only(right: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ScreenTitle(title: "Recipe of the chef"),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.all(16),
                                    child: const Placeholder(
                                      fallbackHeight: 200,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          'Ingredients:',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        _buildIngredients(
                                            recipeOfTheChef.ingredients),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    color: Colors.grey[200],
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          'Steps:',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        _buildSteps(recipeOfTheChef.steps)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              Expanded(
                flex: 1,
                child: _buildCategoryList(context, category),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, List<RecipeCategory> category,
      {int layout = 1}) {
    double width, itemWidth, itemHeight;
    width = MediaQuery.of(context).size.width / 3;
    itemWidth = width / 2.2;
    itemHeight = itemWidth * (0.65);

    if (layout == 2) {
      width = MediaQuery.of(context).size.width;
      itemWidth = width / 2.5;
      itemHeight = itemWidth * (0.6);
    } else if (layout == 3) {
      width = MediaQuery.of(context).size.width;
      itemWidth = width / 2.5;
      itemHeight = itemWidth * (0.7);
    }

    return Column(
      children: [
        ScreenTitle(title: "Explore with Category"),
        SizedBox(height: 16),
        Wrap(
          spacing: 6, // Horizontal space between chips
          runSpacing: 6, // Vertical space between lines
          children: List<Widget>.generate(category.length, (index) {
            return Container(
              width: itemWidth - 12, // Adjusting width based on spacing
              height: itemHeight,
              child: CategoryCard(category: category[index]),
            );
          }),
        ),
        TextButton(
          child: const Text(
            "Show more >>",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
          onPressed: () {
            BottomNavigationBar navigationBar =
                AppGlobal.bottomWidgetKey.currentWidget as BottomNavigationBar;
            navigationBar.onTap!(2);
          },
        )
      ],
    );
  }

  Widget _buildIngredients(List<String> ingredients) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: ingredients.map((ingredient) {
          return Text('- $ingredient');
        }).toList());
  }

  Widget _buildSteps(List<String> steps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: steps.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final step = entry.value;
        return ListTile(
          leading: CircleAvatar(
            child: Text('$index'),
          ),
          title: Text(step),
        );
      }).toList(),
    );
  }
}
