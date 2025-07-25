import '../../data/models/table_model.dart';

abstract class TableEvent {}

class LoadTables extends TableEvent {}

class AddTable extends TableEvent {
  final TableModel table;

  AddTable(this.table);
}

class ChangeTableStatusEvent extends TableEvent {
  final TableModel table;
  final TableStatus newStatus;

  ChangeTableStatusEvent({required this.table, required this.newStatus});
}

class FilterTablesByStatus extends TableEvent {
  final TableStatus? status;
  FilterTablesByStatus(this.status);
}
