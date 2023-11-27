import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jual_buku/models/faq_model.dart';
import 'package:jual_buku/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FaqController {
  static String url = baseUrl + '/faq';

  static Future<List<FaqModel>> fetchFaqData() async {
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
      List<FaqModel> faqList = [];

      for (var item in data) {
        var faq = FaqModel.fromJson(item);
        faqList.add(faq);
      }

      return faqList;
    } else {
      throw Exception('Failed to fetch FAQ data');
    }
  }
}
