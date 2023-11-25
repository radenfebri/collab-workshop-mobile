import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jual_buku/models/transaksi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionController {
  Future<List<Transaksi>> fetchTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = 'http://127.0.0.1:8000/api/pesanan';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> transactionList = jsonData['pesanan'];

      List<Transaksi> transactions = [];

      for (var json in transactionList) {
        final transaksi = Transaksi.fromJson(json);
        transactions.add(transaksi);
      }

      return transactions;
    } else {
      throw Exception(
          'Gagal mengambil data transaksi. Kode Status: ${response.statusCode}');
    }
  }
}
