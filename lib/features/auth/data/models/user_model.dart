class UserModel {
  final String uid;
  final String? email;
  final String? name;
  final String? phone;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.uid,
    this.email,
    this.name,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String uid) {
    return UserModel(
      uid: uid,
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
