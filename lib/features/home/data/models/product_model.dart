import 'category_model.dart';

class MenuModel {
  final String? id;
  final CategoryModel category;
  final String image;
  final String name;
  final int price;
  const MenuModel({
    this.id,
    required this.category,
    required this.image,
    required this.name,
    required this.price,
  });
  factory MenuModel.fromJson(
    String id,
    Map<String, dynamic> json,
    CategoryModel categoryModel,
  ) {
    return MenuModel(
      id: id,
      category: categoryModel,
      image: json['image'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {'category': category, 'image': image, 'name': name, 'price': price};
  }

  MenuModel copyWith({
    String? id,
    CategoryModel? category,
    String? image,
    String? name,
    int? price,
  }) {
    return MenuModel(
      id: id ?? this.id,
      category: category ?? this.category,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}
