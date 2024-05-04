import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_with_me/core/model/recipe_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeCategoryNotifier extends StateNotifier<List<RecipeCategory>> {
  RecipeCategoryNotifier() : super([]) {
    _fetchRecipeCategories();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchRecipeCategories() async {
    final snapshot = await _firestore.collection('category').get();
    final notes = snapshot.docs.map((doc) {
      return RecipeCategory.fromFirestore(doc.data(), doc.id);
    }).toList();

    state = notes;
  }
}

final recipeCategoryProvider =
    StateNotifierProvider<RecipeCategoryNotifier, List<RecipeCategory>>(
        (ref) => RecipeCategoryNotifier());
