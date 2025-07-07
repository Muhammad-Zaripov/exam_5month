class FoodItem {
  final String name;
  int quantity;

  FoodItem({required this.name, required this.quantity});

  Map<String, dynamic> toJson() => {'name': name, 'quantity': quantity};

  static FoodItem fromJson(Map<String, dynamic> json) =>
      FoodItem(name: json['name'], quantity: json['quantity']);
}

extension FoodItemJson on FoodItem {
  Map<String, dynamic> toJson() => {'name': name, 'quantity': quantity};
}

extension FoodItemFactory on FoodItem {
  static FoodItem fromJson(Map<String, dynamic> json) =>
      FoodItem(name: json['name'], quantity: json['quantity']);
}
