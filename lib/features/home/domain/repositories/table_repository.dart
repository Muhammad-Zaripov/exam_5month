import '../../data/models/table_model.dart';

abstract class TableRepository {
  Future<List<TableModel>> getTables();
}