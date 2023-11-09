import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:project_workshop_mobile/constants/constants.dart';
import 'package:project_workshop_mobile/model/user.dart';
import 'package:project_workshop_mobile/views/auth/login_page.dart';
import 'package:project_workshop_mobile/views/home_page.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final user = User(id: 0, name: '', email: '', username: '').obs;
  final box = GetStorage();
  bool get isAuthenticated => token.value.isNotEmpty;

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
    required String c_password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'c_password': c_password,
      };

      var response = await http.post(
        Uri.parse(url + 'auth/register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Registration was successful!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => const LoginPage());
      } else {
        isLoading.value = false;

        if (json.decode(response.body) is Map) {
          final responseData = json.decode(response.body);

          if (responseData.containsKey('error')) {
            final validationErrors = responseData['error'];
            String errorMessage = "Registration failed: Validation Error\n";

            for (var errorField in validationErrors.keys) {
              errorMessage +=
                  "$errorField: ${validationErrors[errorField][0]}\n";
            }

            Get.snackbar(
              'Error',
              errorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else {
            Get.snackbar(
              'Error',
              responseData['message'],
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          Get.snackbar(
            'Error',
            'Registration failed: An error occurred',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        debugPrint(json.encode(json.decode(response.body)));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'username': username,
        'password': password,
      };

      var response = await http.post(
        Uri.parse(url + 'auth/login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        final userDataResponse = await http.get(
          Uri.parse(url + 'get_user_data'),
          headers: {
            'Authorization': 'Bearer ${token.value}',
          },
        );
        Get.snackbar(
          'Success',
          'Login was successful!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => const HomePage());
      } else {
        isLoading.value = false;

        if (json.decode(response.body) is Map) {
          final responseData = json.decode(response.body);

          if (responseData.containsKey('error')) {
            final validationErrors = responseData['error'];
            String errorMessage = "Login failed: Validation Error\n";

            for (var errorField in validationErrors.keys) {
              errorMessage +=
                  "$errorField: ${validationErrors[errorField][0]}\n";
            }

            Get.snackbar(
              'Error',
              errorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else {
            Get.snackbar(
              'Error',
              responseData['message'],
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          Get.snackbar(
            'Error',
            'Login failed: An error occurred',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        debugPrint(json.encode(json.decode(response.body)));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future getDataUser() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final userDataResponse = await http.get(
        Uri.parse(url + 'auth/show'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (userDataResponse.statusCode == 200) {
        final userData = json.decode(userDataResponse.body);
        final id = userData['id'];
        final name = userData['name'];
        final email = userData['email'];
        final username = userData['username'];

        final newUser = User(
          id: id,
          name: name,
          email: email,
          username: username,
        );

        user.value = newUser;
        isLoading.value = false;
        if (user.value != null) {
          print("Data Pengguna: ${user.value.name}");
        } else {
          print("Data Pengguna: Tidak ada data");
        }
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Failed to fetch user data',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future logout() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await http.post(
        Uri.parse(url + 'auth/logout'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        box.remove('token');
        user.update((val) {
          val!.id.value = 0;
          val.name.value = '';
          val.email.value = '';
          val.username.value = '';
        });
        isLoading.value = false;

        Get.offAll(() => const LoginPage());
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Failed to logout',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
