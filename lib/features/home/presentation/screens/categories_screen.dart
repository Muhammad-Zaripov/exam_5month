import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';
import '../widgets/categories_list.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryModel qahvalar = CategoryModel(name: 'Qahvalar');
  final CategoryModel salatlar = CategoryModel(name: 'Salatlar');
  final CategoryModel shirinliklar = CategoryModel(name: 'Shirinliklar');
  final CategoryModel ichimliklar = CategoryModel(name: 'Ichimliklar');
  final CategoryModel asosiyTaomlar = CategoryModel(name: 'Asosiy taomlar');

  late final Map<CategoryModel, List<MenuModel>> categoryProducts = {
    qahvalar: [
      MenuModel(
        name: 'Espresso',
        price: 15000,
        image: 'espresso.jpg',
        category: qahvalar,
      ),
      MenuModel(
        name: 'Cappuccino',
        price: 18000,
        image: 'cappuccino.jpg',
        category: qahvalar,
      ),
      MenuModel(
        name: 'Latte',
        price: 20000,
        image: 'latte.jpg',
        category: qahvalar,
      ),
      MenuModel(
        name: 'Americano',
        price: 17000,
        image: 'americano.jpg',
        category: qahvalar,
      ),
      MenuModel(
        name: 'Mocha',
        price: 22000,
        image: 'mocha.jpg',
        category: qahvalar,
      ),
    ],
    salatlar: [
      MenuModel(
        name: 'Olivye',
        price: 25000,
        image: 'olivye.jpg',
        category: salatlar,
      ),
      MenuModel(
        name: 'Sezar',
        price: 27000,
        image: 'sezar.jpg',
        category: salatlar,
      ),
      MenuModel(
        name: 'Vitamin',
        price: 20000,
        image: 'vitamin.jpg',
        category: salatlar,
      ),
      MenuModel(
        name: 'Tovuq salati',
        price: 28000,
        image: 'tovuq.jpg',
        category: salatlar,
      ),
      MenuModel(
        name: 'Yengil salat',
        price: 19000,
        image: 'yengil.jpg',
        category: salatlar,
      ),
    ],
    shirinliklar: [
      MenuModel(
        name: 'Tiramisu',
        price: 30000,
        image: 'tiramisu.jpg',
        category: shirinliklar,
      ),
      MenuModel(
        name: 'Cheesecake',
        price: 32000,
        image: 'cheesecake.jpg',
        category: shirinliklar,
      ),
      MenuModel(
        name: 'Brownie',
        price: 25000,
        image: 'brownie.jpg',
        category: shirinliklar,
      ),
      MenuModel(
        name: 'Pirog',
        price: 22000,
        image: 'pirog.jpg',
        category: shirinliklar,
      ),
      MenuModel(
        name: 'Donut',
        price: 18000,
        image: 'donut.jpg',
        category: shirinliklar,
      ),
    ],
    ichimliklar: [
      MenuModel(
        name: 'Pepsi',
        price: 10000,
        image: 'pepsi.jpg',
        category: ichimliklar,
      ),
      MenuModel(
        name: 'Coca-Cola',
        price: 10000,
        image: 'cola.jpg',
        category: ichimliklar,
      ),
      MenuModel(
        name: 'Fanta',
        price: 10000,
        image: 'fanta.jpg',
        category: ichimliklar,
      ),
      MenuModel(
        name: 'Sharbat',
        price: 15000,
        image: 'sharbat.jpg',
        category: ichimliklar,
      ),
      MenuModel(
        name: 'Suv',
        price: 5000,
        image: 'suv.jpg',
        category: ichimliklar,
      ),
    ],
    asosiyTaomlar: [
      MenuModel(
        name: 'Osh',
        price: 35000,
        image: 'osh.jpg',
        category: asosiyTaomlar,
      ),
      MenuModel(
        name: 'Lag\'mon',
        price: 33000,
        image: 'lagmon.jpg',
        category: asosiyTaomlar,
      ),
      MenuModel(
        name: 'Shashlik',
        price: 40000,
        image: 'shashlik.jpg',
        category: asosiyTaomlar,
      ),
      MenuModel(
        name: 'Manti',
        price: 30000,
        image: 'manti.jpg',
        category: asosiyTaomlar,
      ),
      MenuModel(
        name: 'Somsa',
        price: 12000,
        image: 'somsa.jpg',
        category: asosiyTaomlar,
      ),
    ],
  };

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: const Text(
          "Kategoriyalar",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Spacer(),
          CategoriesList(categoryProducts: categoryProducts),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
