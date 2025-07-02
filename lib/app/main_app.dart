import 'package:exam_5month/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../features/home/presentation/screens/categories_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: RestaurantHomeScreen()));
  }
}
