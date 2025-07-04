import 'package:flutter/material.dart';

class TableSeatsSelector extends StatelessWidget {
  final int selectedValue;
  final ValueChanged<int> onChanged;

  const TableSeatsSelector({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [2, 4, 6, 8].map((seat) {
        return Expanded(
          child: RadioListTile<int>(
            title: Text('$seat'),
            value: seat,
            groupValue: selectedValue,
            onChanged: (val) => onChanged(val!),
          ),
        );
      }).toList(),
    );
  }
}
