import 'package:flutter/material.dart';

import '../../data/models/table_model.dart';

class BalanceScreen extends StatelessWidget {
  final TableModel table;
  final VoidCallback onPaid;
  const BalanceScreen({super.key, required this.table, required this.onPaid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: []),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          table.status = TableStatus.cleaning;
          onPaid();
          Navigator.pop(context);
        },
        backgroundColor: Color(0xFF2E9055),
        label: Text(
          'Hisob to\'landi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
