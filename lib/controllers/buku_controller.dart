import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jual_buku/models/buku_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BukuController {
  static const String baseUrl = 'http://127.0.0.1:8000/api/buku';

  Future<List<Buku>> getBukuList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      var url = '$baseUrl';
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<Buku> bukuList = [];

        for (var item in data['data']) {
          var buku = Buku.fromJson(item);
          bukuList.add(buku);
        }

        return bukuList;
      } else {
        throw Exception('Failed to get book list');
      }
    } else {
      throw Exception('User is not logged in');
    }
  }

  Future<Buku> getBukuById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      var url = '$baseUrl/$id';
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var buku = Buku.fromJson(data);
        return buku;
      } else {
        throw Exception('Failed to get book');
      }
    } else {
      throw Exception('User is not logged in');
    }
  }
}
