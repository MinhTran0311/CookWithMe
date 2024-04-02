class RecipeCategory {
  final String id;
  final String category;

  RecipeCategory({required this.id, required this.category});

  factory RecipeCategory.fromFirestore(Map<String, dynamic> data, String id) {
    return RecipeCategory(id: id, category: data['name']);
  }
}
