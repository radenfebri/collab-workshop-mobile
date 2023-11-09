import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_workshop_mobile/controllers/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationController authController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (authController.user.value != null) {
                return Text(
                  'Selamat datang, ${authController.user.value.name}',
                  style: const TextStyle(fontSize: 24),
                );
              } else {
                return Text(
                  'Selamat datang di Halaman Utama',
                  style: const TextStyle(fontSize: 24),
                );
              }
            }),
            ElevatedButton(
              onPressed: () {
                authController.logout();
              },
              child: Text(
                'Log Out',
                style: GoogleFonts.poppins(
                    fontSize: size * 0.040, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
