import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_with_me/core/model/recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeNotifier extends StateNotifier<List<Recipe>> {
  RecipeNotifier() : super([]) {
    _fetchRecipes();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchRecipes() async {
    final snapshot = await _firestore.collection('recipes').get();
    final notes = snapshot.docs.map((doc) {
      return Recipe.fromFirestore(doc.data(), doc.id);
    }).toList();

    state = notes;
  }

  void deleteRecipe(String id) async {
    await _firestore.collection('recipes').doc(id).delete();
    state = state.where((recipe) => recipe.id != id).toList();
  }

  Recipe getRecipeById(String id) {
    if (id.isEmpty) {
      return state.elementAt(Random().nextInt(state.length));
    }
    return state.where((element) => element.id == id).first;
  }

  Future<List<Recipe>> searchRecipe(String name) async {
    final snapshot = await _firestore.collection('recipes').get();
    final recipes = snapshot.docs
        .map((doc) {
          return Recipe.fromFirestore(doc.data(), doc.id);
        })
        .where((element) =>
            element.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
    return recipes;
  }

  List<Recipe> getRecipesByCategory(String category) {
    return state
        .where((element) =>
            element.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}

final recipeProvider = StateNotifierProvider<RecipeNotifier, List<Recipe>>(
    (ref) => RecipeNotifier());
