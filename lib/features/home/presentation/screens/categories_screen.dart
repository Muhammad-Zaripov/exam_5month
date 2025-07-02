import 'package:flutter/material.dart';

import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../widgets/categories_list.dart';

class CategoriesScreen extends StatelessWidget {
  final Map<String, List<ProductModel>> categoryProducts = {
    'Qahvalar': [
      ProductModel(name: 'Espresso', price: 15000, image: 'espresso.jpg'),
      ProductModel(name: 'Cappuccino', price: 18000, image: ''),
      ProductModel(name: 'Latte', price: 20000, image: 'latte.jpg'),
      ProductModel(name: 'Americano', price: 17000, image: ''),
      ProductModel(name: 'Mocha', price: 22000, image: ''),
    ],
    'Salatlar': [
      ProductModel(name: 'Olivye', price: 25000, image: ''),
      ProductModel(name: 'Sezar', price: 27000, image: ''),
      ProductModel(name: 'Vitamin', price: 20000, image: ''),
      ProductModel(name: 'Tovuq salati', price: 28000, image: ''),
      ProductModel(name: 'Yengil salat', price: 19000, image: ''),
    ],
    'Shirinliklar': [
      ProductModel(name: 'Tiramisu', price: 30000, image: ''),
      ProductModel(name: 'Cheesecake', price: 32000, image: ''),
      ProductModel(name: 'Brownie', price: 25000, image: ''),
      ProductModel(name: 'Pirog', price: 22000, image: ''),
      ProductModel(name: 'Donut', price: 18000, image: ''),
    ],
    'Ichimliklar': [
      ProductModel(name: 'Pepsi', price: 10000, image: ''),
      ProductModel(name: 'Coca-Cola', price: 10000, image: ''),
      ProductModel(name: 'Fanta', price: 10000, image: ''),
      ProductModel(name: 'Sharbat', price: 15000, image: ''),
      ProductModel(name: 'Suv', price: 5000, image: ''),
    ],
    'Asosiy taomlar': [
      ProductModel(name: 'Osh', price: 35000, image: ''),
      ProductModel(name: 'Lag\'mon', price: 33000, image: ''),
      ProductModel(name: 'Shashlik', price: 40000, image: ''),
      ProductModel(name: 'Manti', price: 30000, image: ''),
      ProductModel(name: 'Somsa', price: 12000, image: ''),
    ],
  };

  CategoriesScreen({super.key});

  void _showCategoryBottomSheet(BuildContext context, CategoryModel category) {
    final products = categoryProducts[category.name] ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              int count = 0;

              return StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade300,
                        child: Center(child: Icon(Icons.image)),
                      ),
                      title: Text(product.name),
                      subtitle: Text("${product.price} so'm"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (count > 0) {
                                setState(() => count--);
                              }
                            },
                          ),
                          Text('$count'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() => count++);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(backgroundColor: Color(0xFFF8F9FA)),
      body: Column(
        children: [
          Spacer(),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return SizedBox();
              },
            ),
          ),
          CategoriesList(
            onCategoryTap: (category) =>
                _showCategoryBottomSheet(context, category),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
