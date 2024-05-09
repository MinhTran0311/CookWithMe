import 'dart:math';

import 'package:cook_with_me/core/constants/breakpoints.dart';
import 'package:cook_with_me/core/model/recipe.dart';
import 'package:cook_with_me/core/provider/recipe_provider.dart';
import 'package:cook_with_me/modules/common/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeScreen extends ConsumerWidget {
  final String recipeId;
  final bool isRandomRecipe;
  const RecipeScreen(
      {super.key, this.recipeId = "", this.isRandomRecipe = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeProvider);
    final recipe = recipeId.isNotEmpty
        ? recipes.where((element) => element.id == recipeId).firstOrNull
        : (recipes.isEmpty
            ? null
            : recipes.elementAtOrNull(
                Random().nextInt(ref.watch(recipeProvider).length)));

    return recipe == null
        ? Center(child: const CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < Breakpoints.sm) {
                return _buildMobileLayout(recipe);
              } else if (constraints.maxWidth < Breakpoints.lg) {
                return _buildTabletLayout(recipe);
              } else {
                return _buildDesktopLayout(recipe);
              }
            }),
          );
  }

  Widget _buildMobileLayout(Recipe recipe) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ScreenTitle(
              title: isRandomRecipe
                  ? recipe.name + " - Recipe"
                  : ("Recipe of the day!!! \n" + recipe.name + " - Recipe")),
          SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(16),
            child: const Placeholder(
              fallbackHeight: 200,
            ), // Placeholder for image
          ),
          SizedBox(height: 16),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Ingredients:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildIngredients(recipe.ingredients),
              ],
            ),
          ),
          const SizedBox(height: 16),
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
                _buildSteps(recipe.steps)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabletLayout(Recipe recipe) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ScreenTitle(
              title: isRandomRecipe
                  ? recipe.name + " - Recipe"
                  : ("Recipe of the day!!! \n" + recipe.name + " - Recipe")),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Ingredients:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildIngredients(recipe.ingredients),
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
                          _buildSteps(recipe.steps)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(Recipe recipe) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ScreenTitle(
              title: isRandomRecipe
                  ? recipe.name + " - Recipe"
                  : ("Recipe of the day!!! \n" + recipe.name + " - Recipe")),
          SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(16),
                      child: const Placeholder(
                        fallbackHeight: 400,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Ingredients:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildIngredients(recipe.ingredients),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              Container(
                width: 400,
                child: Column(
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
                          _buildSteps(recipe.steps)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
