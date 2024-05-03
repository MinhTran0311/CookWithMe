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

  void addRecipe(String name) async {
    final recipeData = Recipe(id: '', name: name).toFireStore();

    final noteRef = await _firestore.collection('recipes').add(recipeData);
    final note = Recipe.fromFirestore(recipeData, noteRef.id);

    state = [...state, note];
  }

  void deleteRecipe(String id) async {
    await _firestore.collection('recipes').doc(id).delete();
    state = state.where((recipe) => recipe.id != id).toList();
  }

  Future<List<Recipe>> searchRecipe(String name) async {
    final snapshot = await _firestore.collection('recipes').get();
    final recipes = snapshot.docs
        .map((doc) {
          return Recipe.fromFirestore(doc.data(), doc.id);
        })
        .where((element) => element.name.contains(name))
        .toList();
    return recipes;
  }
}

final recipeProvider = StateNotifierProvider<RecipeNotifier, List<Recipe>>(
    (ref) => RecipeNotifier());
