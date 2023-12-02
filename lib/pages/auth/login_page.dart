import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jual_buku/controllers/auth_controller.dart';
import 'package:jual_buku/models/user_model.dart';
import 'package:jual_buku/pages/auth/register_page.dart';
import 'package:jual_buku/pages/auth/reset-password_page.dart';
import 'package:jual_buku/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  String _errorMessage = '';

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      UserModel user = await _authController.login(
        username: username,
        password: password,
      );

      _showSuccessDialog(context, user);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _goToResetPasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
    );
  }

  void _showSuccessDialog(BuildContext context, UserModel user) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Login Berhasil',
      desc: 'Kamu Berhasil login.',
      btnOkText: 'OK',
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(user: user)),
        );
      },
      width: MediaQuery.of(context).size.width * 0.7,
    )..show();
  }

  void _goToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  Widget _buildErrorMessage() {
    if (_errorMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          _errorMessage,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 14.0,
              color: Colors.red,
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 32.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorText: _errorMessage.isNotEmpty &&
                          _errorMessage.contains('invalid_username')
                      ? 'Username tidak valid'
                      : null,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorText: _errorMessage.isNotEmpty &&
                          _errorMessage.contains('invalid_password')
                      ? 'Password tidak valid'
                      : null,
                ),
                obscureText: true,
              ),
              _buildErrorMessage(),
              SizedBox(height: 24.0),
              ElevatedButton.icon(
                onPressed: _login,
                icon: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF177DFF),
                  padding:
                      EdgeInsets.symmetric(horizontal: 48.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  elevation: 4,
                  shadowColor: Colors.black54,
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: _goToRegisterPage,
                child: Text(
                  'Belum punya akun? Daftar disini',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color(0xFF177DFF),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: _goToResetPasswordPage,
                child: Text(
                  'Lupa password? Reset disini',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color(0xFF177DFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
