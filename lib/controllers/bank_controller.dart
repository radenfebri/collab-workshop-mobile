import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jual_buku/models/bank_model.dart';
import 'package:jual_buku/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankController {
  static String url = baseUrl + '/metode-bayar';

  static Future<List<MetodePembayaran>> fetchBanks() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var data = responseData['data'] as List<dynamic>;
      List<MetodePembayaran> bankList = [];

      for (var item in data) {
        var bank = MetodePembayaran.fromJson(item);
        bankList.add(bank);
      }

      return bankList;
    } else {
      throw Exception('Failed to fetch banks');
    }
  }
}
