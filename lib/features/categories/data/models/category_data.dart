import 'package:flutter/material.dart';

class CategoryData {
  final String name;
  final IconData icon;
  final String firebasePath;
  final List<String> initialItems;

  CategoryData({
    required this.name,
    required this.icon,
    required this.firebasePath,
    required this.initialItems,
  });
}
