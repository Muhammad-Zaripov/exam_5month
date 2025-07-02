import 'package:exam_5month/features/home/presentation/screens/balance_screen.dart';
import 'package:exam_5month/features/home/presentation/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import '../../data/models/table_model.dart';

class TableDetailsBottomSheet extends StatelessWidget {
  final VoidCallback onCleaned;
  final TableModel table;
  const TableDetailsBottomSheet({
    super.key,
    required this.table,
    required this.onCleaned,
  });
  void _handleAction(BuildContext context) {
    switch (table.status) {
      case TableStatus.available:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (cxt) => CategoriesScreen()),
        );
        break;
      case TableStatus.occupied:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (cxt) => BalanceScreen(table: table, onPaid: () {}),
          ),
        );
        break;
      case TableStatus.reserved:
        table.status = TableStatus.occupied;
        onCleaned();
        Navigator.pop(context);
        break;
      case TableStatus.cleaning:
        table.status = TableStatus.available;
        onCleaned();
        Navigator.pop(context);
        break;
    }
  }

  String _getActionText() {
    switch (table.status) {
      case TableStatus.available:
        return 'Band qilish';
      case TableStatus.occupied:
        return 'Hisobni ko‘rish';
      case TableStatus.reserved:
        return 'Mijozlarni joylashtirish';
      case TableStatus.cleaning:
        return 'Toza deb belgilash';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.table_restaurant, size: 30, color: Color(0xFF2E9055)),
              SizedBox(width: 15),
              Text(
                'Stol ${table.number}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildDetailRow('O‘rinlar', '${table.seats} kishi'),
          _buildDetailRow('Holati', table.status.name.toUpperCase()),
          if (table.customerName != null)
            _buildDetailRow('Mijoz', table.customerName!),
          if (table.reservationTime != null)
            _buildDetailRow(
              'Band vaqti',
              '${table.reservationTime!.hour}:${table.reservationTime!.minute.toString().padLeft(2, '0')}',
            ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Yopish',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleAction(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E9055),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    _getActionText(),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
