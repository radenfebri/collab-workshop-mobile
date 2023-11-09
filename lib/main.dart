import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_workshop_mobile/controllers/authentication.dart'; // Impor kontroler Anda di sini
import 'package:project_workshop_mobile/views/auth/login_page.dart';
import 'package:project_workshop_mobile/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tuku Buku',
      initialBinding: BindingsBuilder(() {
        Get.put(AuthenticationController()); // Inisialisasi kontroler
      }),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authController =
        Get.find<AuthenticationController>();

    return Obx(() {
      if (authController.isAuthenticated) {
        return const HomePage();
      } else {
        return const LoginPage();
      }
    });
  }
}
