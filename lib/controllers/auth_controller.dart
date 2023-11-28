import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jual_buku/models/user_model.dart';
import 'package:jual_buku/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String url = baseUrl + '/auth';

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'username': username,
      'password': password,
    });

    var response = await http.post(
      Uri.parse('$url/login'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data['user']);
      var token = data['token'];

      // Simpan token ke SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      user.token = token;

      return user;
    } else {
      var error = jsonDecode(response.body);
      var errorMessage = error['message'];
      print("$errorMessage");
      throw ("$errorMessage");
    }
  }

  Future<void> register(
      String name, String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$url/register'),
      body: {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Registration failed');
    }
  }
}
