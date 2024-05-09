class Recipe {
  final String id;
  final String name;
  final String category;
  final List<String> steps;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.steps,
    required this.ingredients,
    required this.category,
  });

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    List<String> steps =
        (data['steps'] as List<dynamic>).map((step) => step as String).toList();
    List<String> ingredients = (data['ingredients'] as List<dynamic>)
        .map((ingredient) => ingredient as String)
        .toList();

    return Recipe(
        id: id,
        name: data['name'],
        steps: steps,
        ingredients: ingredients,
        category: data["category"]);
  }
}
