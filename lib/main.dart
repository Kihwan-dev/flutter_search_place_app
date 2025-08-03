import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/data/repositories/review_repository.dart';
import 'package:flutter_search_place_app/firebase_options.dart';
import 'package:flutter_search_place_app/ui/pages/home/home_page.dart';
import 'package:flutter_search_place_app/ui/pages/review/review_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final place = Place(title: "타이틀", category: "카테고리", roadAddress: "주소", mapX: 127.0929309, mapY: 37.4242296);
    return MaterialApp(
      home: ReviewPage(place),
      // home: HomePage(),
    );
  }
}
