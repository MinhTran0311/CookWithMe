import 'package:cook_with_me/modules/common/widgets/recipe_search.dart';
import 'package:flutter/material.dart';

AppBar buildTopBar(BuildContext context) {
  return AppBar(
    title: Text("Cook With Me"),
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
          onPressed: () {
            showSearch(context: context, delegate: RecipeSearch());
          },
          icon: Icon(Icons.search))
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(2.0),
      child: Container(
        color: Colors.black,
        height: 2.0,
      ),
    ),
  );
}
// Navigator.of(context).push(MaterialPageRoute(
//                 builder: (_) => Scaffold(
//                       appBar: AppBar(
//                         title: const Text('New Page'),
//                       ),
//                     )));