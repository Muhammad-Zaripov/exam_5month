import '../../data/models/table_model.dart';

abstract class TableState {}

class TableInitial extends TableState {}

class TableLoading extends TableState {}

class TableLoaded extends TableState {
  final List<TableModel> tables;
  TableLoaded(this.tables);
}

class TableError extends TableState {
  final String message;
  TableError(this.message);
}
