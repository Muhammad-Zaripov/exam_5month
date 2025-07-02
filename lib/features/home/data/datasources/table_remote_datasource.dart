import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/table_model.dart';

class TableRemoteDataSource {
  final String url =
      'https://restaurant-automatical-default-rtdb.asia-southeast1.firebasedatabase.app/table.json';

  Future<List<TableModel>> fetchTables() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body.isEmpty || response.body == 'null') {
          return [];
        }
        final data = json.decode(response.body);
        if (data is Map<String, dynamic>) {
          final tables = data.values.map((e) {
            return TableModel.fromJson(e as Map<String, dynamic>);
          }).toList();
          return List<TableModel>.from(tables);
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load tables: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ma’lumotlarni olishda xato: $e');
    }
  }

  Future<void> addTable(TableModel table) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(table.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add table: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Yangi stolni qo‘shishda xato: $e');
    }
  }
}
