import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_with_me/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final snapshot = await _firestore.collection('category').get();
  snapshot.docs.forEach((doc) => print('${doc.id}: ${doc.data()}'));

  runApp(ProviderScope(
      //overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: MaterialApp.router(
          title: "Quiz",
          routerConfig: getRouter(),
          theme: ThemeData(
              useMaterial3: true,
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: Colors.purple)))));
}
