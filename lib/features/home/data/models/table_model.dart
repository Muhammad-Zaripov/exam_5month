import '../../../auth/data/models/user_model.dart';

enum TableStatus { available, cleaning, reserved, occupied }

TableStatus tableStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'available':
      return TableStatus.available;
    case 'reserved':
      return TableStatus.reserved;
    case 'occupied':
      return TableStatus.occupied;
    case 'cleaning':
      return TableStatus.cleaning;
    default:
      return TableStatus.available;
  }
}

String tableStatusToString(TableStatus status) {
  return status.name;
}

class TableModel {
  final String? id;
  final int seats;
  TableStatus status;
  final int tableNumber;
  final UserModel? user;

  TableModel({
    this.id,
    required this.seats,
    required this.status,
    required this.tableNumber,
    this.user,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      seats: json['seats'],
      status: TableStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TableStatus.available,
      ),
      tableNumber: json['tableNumber'],
      user: json['user'] == 'null' ? null : json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seats': seats,
      'status': tableStatusToString(status),
      'tableNumber': tableNumber,
      'user': user?.id ?? 'null',
    };
  }

  TableModel copyWith({
    String? id,
    int? seats,
    TableStatus? status,
    int? tableNumber,
    UserModel? user,
  }) {
    return TableModel(
      id: id ?? this.id,
      seats: seats ?? this.seats,
      status: status ?? this.status,
      tableNumber: tableNumber ?? this.tableNumber,
      user: user ?? this.user,
    );
  }
}
