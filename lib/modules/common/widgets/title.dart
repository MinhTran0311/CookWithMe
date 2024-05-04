import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  ScreenTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }
}
