import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_with_me/core/router/router.dart';
import 'package:cook_with_me/modules/config/custom_router.dart';
import 'package:cook_with_me/modules/config/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // This line is crucial

  // // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // // Firestore usage
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final snapshot = await _firestore.collection('recipes').get();
  snapshot.docs.forEach((doc) => print('${doc.id}: ${doc.data()}'));

  // Running the app
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quizzz",
      //routerConfig: getRouter(),
      onGenerateRoute: CustomRouter.onGenerateRoute,
      initialRoute: RoutePaths.Home,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    ),
  ));
}
