import 'package:flutter/material.dart';

import '../../data/models/category_model.dart';

class CategoriesList extends StatelessWidget {
  final void Function(CategoryModel)? onCategoryTap;

  CategoriesList({super.key, this.onCategoryTap});

  final List<CategoryModel> categories = [
    CategoryModel(name: 'Qahvalar', icon: Icons.local_cafe),
    CategoryModel(name: 'Salatlar', icon: Icons.local_dining),
    CategoryModel(name: 'Shirinliklar', icon: Icons.cake),
    CategoryModel(name: 'Ichimliklar', icon: Icons.local_drink),
    CategoryModel(name: 'Asosiy taomlar', icon: Icons.restaurant_menu),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                onCategoryTap?.call(category);
              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category.icon, color: Color(0xFF2E9055), size: 30),
                    SizedBox(height: 8),
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
