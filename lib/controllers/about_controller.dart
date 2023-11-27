import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jual_buku/models/about_model.dart';
import 'package:jual_buku/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutController {
  static String url = baseUrl + '/about';

  static Future<List<AboutModel>> fetchAboutData() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var aboutData = AboutModel.fromJson(responseData['data']);
      return [aboutData];
    } else {
      throw Exception('Failed to fetch about data');
    }
  }
}
