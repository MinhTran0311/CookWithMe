import 'dart:html';

import 'package:cook_with_me/core/provider/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeSearch extends SearchDelegate<String> {
  final recentRecipes = ["Vegetable Stir Fry", "Beef Tacos"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement the search results logic
    // For now, just return a placeholder widget
    return Center(
      child: Text("Search Results for \"$query\""),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchResult(query: query);
  }
}

class SearchResult extends ConsumerWidget {
  final String query;

  const SearchResult({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref
        .watch(recipeProvider)
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          print(recipes[index].name);
        },
        leading: Icon(Icons.restaurant_menu),
        title: RichText(
          text: TextSpan(
            text: recipes[index].name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      itemCount: recipes.length,
    );
  }
}
