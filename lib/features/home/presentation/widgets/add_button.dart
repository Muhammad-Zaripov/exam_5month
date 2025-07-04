import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/table_model.dart';
import '../bloc/table_bloc.dart';
import '../bloc/table_event.dart';
import '../bloc/table_state.dart';
import 'table_sector_state.dart';

class AddTableButton extends StatelessWidget {
  const AddTableButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(
      builder: (context, state) {
        if (state is TableLoaded) {
          return FloatingActionButton.extended(
            onPressed: () => showAddTableBottomSheet(context, state.tables),
            backgroundColor: const Color(0xFF2E9055),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Yangi stol qo\'shish',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

void showAddTableBottomSheet(
  BuildContext context,
  List<TableModel> currentTables,
) {
  final ValueNotifier<int> selectedSeats = ValueNotifier<int>(2);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder<int>(
          valueListenable: selectedSeats,
          builder: (context, value, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Yangi stol qo\'shish',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text('O\'rinlar sonini tanlang'),
                const SizedBox(height: 10),
                TableSeatsSelector(
                  selectedValue: value,
                  onChanged: (val) => selectedSeats.value = val,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final newTable = TableModel(
                        seats: value,
                        status: TableStatus.available,
                        tableNumber: currentTables.length + 1,
                        user: null,
                      );
                      context.read<TableBloc>().add(AddTable(newTable));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E9055),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Qo\'shish',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
