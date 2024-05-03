import 'package:cook_with_me/modules/common/widgets/recipe_search.dart';
import 'package:flutter/material.dart';

class ScreenFrame extends StatefulWidget {
  const ScreenFrame({super.key, required this.body});

  final Widget body;

  @override
  State<ScreenFrame> createState() => _ScreenFrameState();
}

class _ScreenFrameState extends State<ScreenFrame> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTopBar(context),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                child: widget.body)),
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  BottomNavigationBar buildBottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.shuffle),
          label: 'Random',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: 'Categories',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  AppBar buildTopBar(BuildContext context) {
    return AppBar(
      title: Text("Cook With Me"),
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
}
