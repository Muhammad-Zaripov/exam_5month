enum TableStatus { available, occupied, reserved, cleaning }

class TableModel {
  final int number;
  final int seats;
  TableStatus status;
  final String? customerName;
  final DateTime? reservationTime;

  TableModel({
    required this.number,
    required this.seats,
    required this.status,
    this.customerName,
    this.reservationTime,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      number: json['number'],
      seats: json['seats'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'number': number, 'seats': seats, 'status': status};
  }

  TableModel copyWith({
    int? number,
    int? seats,
    TableStatus? status,
    String? customerName,
    DateTime? reservationTime,
  }) {
    return TableModel(
      number: number ?? this.number,
      seats: seats ?? this.seats,
      status: status ?? this.status,
      customerName: customerName ?? this.customerName,
      reservationTime: reservationTime ?? this.reservationTime,
    );
  }
}
