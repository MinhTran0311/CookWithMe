import 'package:cook_with_me/core/constants/globals.dart';
import 'package:cook_with_me/core/enums/bottom_nav_item.dart';
import 'package:cook_with_me/modules/common/widgets/top_bar.dart';
import 'package:cook_with_me/modules/common/widgets/tab_navigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavItem selectedItem = BottomNavItem.two;

  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNavItem.one: GlobalKey<NavigatorState>(),
    BottomNavItem.two: GlobalKey<NavigatorState>(),
    BottomNavItem.three: GlobalKey<NavigatorState>(),
  };

  final Map<BottomNavItem, IconData> items = const {
    BottomNavItem.one: Icons.receipt,
    BottomNavItem.two: Icons.home,
    BottomNavItem.three: Icons.category,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTopBar(context),
      body: WillPopScope(
        onWillPop: () async {
          // This is when you want to remove all the pages from the
          // stack for the specific BottomNav item.
          navigatorKeys[selectedItem]
              ?.currentState
              ?.popUntil((route) => route.isFirst);

          return false;
        },
        child: Stack(
          children: items
              .map(
                (item, _) => MapEntry(
                  item,
                  _buildOffstageNavigator(item, item == selectedItem),
                ),
              )
              .values
              .toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: AppGlobal.bottomWidgetKey,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: BottomNavItem.values.indexOf(selectedItem),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => _switchTab(index),
        items: items
            .map((item, icon) => MapEntry(
                item.toString(),
                BottomNavigationBarItem(
                    label: '',
                    icon: Icon(
                      icon,
                      size: 30.0,
                    ))))
            .values
            .toList(),
      ),
    );
  }

  void _switchTab(int index) {
    final currentSelectedItem = BottomNavItem.values[index];
    if (selectedItem == currentSelectedItem) {
      navigatorKeys[selectedItem]
          ?.currentState
          ?.popUntil((route) => route.isFirst);
    }
    setState(() {
      selectedItem = currentSelectedItem;
    });
  }

  Widget _buildOffstageNavigator(BottomNavItem currentItem, bool isSelected) {
    return Offstage(
      offstage: !isSelected,
      child: TabNavigator(
        navigatorKey: navigatorKeys[currentItem]!,
        item: currentItem,
      ),
    );
  }
}
