import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jual_buku/models/transaksi_model.dart';
import 'package:jual_buku/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionController {
  Future<List<Transaksi>> fetchTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = baseUrl + '/pesanan';

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

  Future<void> deleteTransaction(int idPesanan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    print(idPesanan);
    final response = await http.delete(
      Uri.parse('$baseUrl/pesanan/$idPesanan/delete'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
