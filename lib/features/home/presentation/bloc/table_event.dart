import '../../data/models/table_model.dart';

abstract class TableEvent {}

class LoadTables extends TableEvent {}

class AddTable extends TableEvent {
  final TableModel table;

  AddTable(this.table);
}
