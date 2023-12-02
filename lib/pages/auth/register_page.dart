import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jual_buku/controllers/auth_controller.dart';
import 'package:jual_buku/pages/auth/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  String _errorMessage = '';

  Future<void> _register() async {
    final String name = _nameController.text;
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      await _authController.register(name, username, email, password);

      // Registration success, show success dialog
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Registrasi Sukses',
        desc: 'Kamu Berhasil register.',
        btnOkText: 'Close',
        btnOkOnPress: () {
          Navigator.of(context).pop();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        width: MediaQuery.of(context).size.width * 0.7,
      )..show();
    } catch (e) {
      // Registration failed, show error message
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Widget _buildErrorMessage() {
    if (_errorMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          _errorMessage,
          style: TextStyle(
            color: Colors.red,
            fontSize: 14.0,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  void _goToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  labelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  labelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  labelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  labelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                obscureText: true,
              ),
              _buildErrorMessage(),
              SizedBox(height: 24.0),
              ElevatedButton.icon(
                onPressed: _register,
                icon: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                label: Text(
                  'Register',
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
                onPressed: _goToLoginPage,
                child: Text(
                  'Sudah memiliki akun? Lanjut Login',
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
