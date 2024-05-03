class Recipe {
  final String id;
  final String name;

  Recipe({required this.id, required this.name});

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(id: id, name: data['name']);
  }

  Map<String, dynamic> toFireStore() {
    return {
      'name': name,
    };
  }
}
