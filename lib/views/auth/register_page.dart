import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_workshop_mobile/controllers/authentication.dart';
import 'package:project_workshop_mobile/views/auth/login_page.dart';
import 'package:project_workshop_mobile/views/home_page.dart';
import 'package:project_workshop_mobile/views/wigets/input_wigets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _c_passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Regitser Page',
                style: GoogleFonts.poppins(fontSize: size * 0.080),
              ),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                hintText: 'Name',
                obscureText: false,
                controller: _nameController,
              ),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                hintText: 'Username',
                obscureText: false,
                controller: _usernameController,
              ),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: _c_passwordController,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                onPressed: () async {
                  if (_authenticationController.isAuthenticated) {
                    // Pengguna sudah login, arahkan mereka ke halaman lain, misalnya HomePage
                    Get.offAll(() => const HomePage());
                  } else {
                    await _authenticationController.register(
                      name: _nameController.text.trim(),
                      username: _usernameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      c_password: _c_passwordController.text.trim(),
                    );
                  }
                },
                child: Obx(() {
                  return _authenticationController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          _authenticationController.isAuthenticated
                              ? 'Go to HomePage'
                              : 'Register',
                          style: GoogleFonts.poppins(
                            fontSize: size * 0.040,
                          ),
                        );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const LoginPage());
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.040, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
