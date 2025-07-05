import 'package:exam_5month/features/categories/presentation/screens/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/table_model.dart';
import '../bloc/table_bloc.dart';
import '../bloc/table_event.dart';

class BottomSheetWidget extends StatelessWidget {
  final TableModel table;
  final TableStatus status;

  const BottomSheetWidget({
    super.key,
    required this.status,
    required this.table,
  });

  @override
  Widget build(BuildContext context) {
    final List<_StatusAction> actions = _getActionsByStatus(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions
            .map(
              (action) => ListTile(
                leading: Icon(action.icon, color: const Color(0xFF4CAF50)),
                title: Text(action.title),
                onTap: action.onTap,
              ),
            )
            .toList(),
      ),
    );
  }

  List<_StatusAction> _getActionsByStatus(BuildContext context) {
    switch (status) {
      case TableStatus.available:
        return [
          _StatusAction(
            icon: Icons.people,
            title: 'Mijozga qarash',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => Categoriesly()),
              );
            },
          ),
          _StatusAction(
            icon: Icons.check_circle,
            title: 'Band qilish',
            onTap: () {
              context.read<TableBloc>().add(
                ChangeTableStatusEvent(
                  table: table,
                  newStatus: TableStatus.reserved,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ];
      case TableStatus.occupied:
        return [
          _StatusAction(
            icon: Icons.people,
            title: 'Mijozga qarash',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => Categoriesly()),
              );
            },
          ),
          _StatusAction(
            icon: Icons.cleaning_services,
            title: 'Tozalashga belgilash',
            onTap: () {
              context.read<TableBloc>().add(
                ChangeTableStatusEvent(
                  table: table,
                  newStatus: TableStatus.cleaning,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ];
      case TableStatus.reserved:
        return [
          _StatusAction(
            icon: Icons.schedule,
            title: 'Zaxirani bekor qilish',
            onTap: () {
              context.read<TableBloc>().add(
                ChangeTableStatusEvent(
                  table: table,
                  newStatus: TableStatus.available,
                ),
              );
              Navigator.pop(context);
            },
          ),
          _StatusAction(
            icon: Icons.people,
            title: 'Mijozlarni joylashtirish',
            onTap: () {
              context.read<TableBloc>().add(
                ChangeTableStatusEvent(
                  table: table,
                  newStatus: TableStatus.occupied,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ];
      case TableStatus.cleaning:
        return [
          _StatusAction(
            icon: Icons.cleaning_services,
            title: 'Tozalandi deb belgilash',
            onTap: () {
              context.read<TableBloc>().add(
                ChangeTableStatusEvent(
                  table: table,
                  newStatus: TableStatus.available,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ];
    }
  }
}

class _StatusAction {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  _StatusAction({required this.icon, required this.title, required this.onTap});
}
