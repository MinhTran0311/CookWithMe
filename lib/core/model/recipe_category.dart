class RecipeCategory {
  final String id;
  final String name;

  RecipeCategory({required this.id, required this.name});

  factory RecipeCategory.fromFirestore(Map<String, dynamic> data, String id) {
    return RecipeCategory(id: id, name: data['name']);
  }
}
