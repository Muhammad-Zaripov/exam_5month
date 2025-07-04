import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/table_model.dart';

class TableRemoteDataSource {
  final String baseUrl =
      'https://restaurant-automatical-default-rtdb.asia-southeast1.firebasedatabase.app/table';

  Future<List<TableModel>> fetchTables() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl.json'));
      if (response.statusCode == 200) {
        if (response.body.isEmpty || response.body == 'null') {
          return [];
        }
        final data = json.decode(response.body);
        if (data is Map<String, dynamic>) {
          final tables = data.entries.map((entry) {
            final table = TableModel.fromJson(entry.value);
            return table.copyWith(
              id: entry.key,
            ); // id Firebase dan kelmaydi, key sifatida keladi
          }).toList();
          return tables;
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
        Uri.parse('$baseUrl.json'),
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

  Future<void> updateTable(TableModel table) async {
    final url = Uri.parse('$baseUrl/${table.id}.json');

    await http.patch(url, body: jsonEncode({'status': table.status.name}));
  }
}
