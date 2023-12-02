import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jual_buku/controllers/auth_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';

  AuthController _authController = AuthController();

  void _resetPassword() {
    String email = _emailController.text;
    _authController.resetPassword(email: email).then((_) {
      setState(() {
        _errorMessage = 'Reset Password Email Sent';
      });
    }).catchError((error) {
      setState(() {
        _errorMessage = error.toString();
      });
    });
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
              color: _errorMessage == 'Reset Password Email Sent'
                  ? Colors.green
                  : Colors.red,
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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
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
                          _errorMessage.contains('invalid_email')
                      ? 'Email tidak valid'
                      : null,
                ),
              ),
              _buildErrorMessage(),
              SizedBox(height: 24.0),
              ElevatedButton.icon(
                onPressed: _resetPassword,
                icon: Icon(
                  Icons.vpn_key,
                  color: Colors.white,
                ),
                label: Text(
                  'Reset Password',
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
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman login
                },
                child: Text(
                  'Kembali ke halaman login',
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
