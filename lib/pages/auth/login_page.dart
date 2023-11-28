import 'package:flutter/material.dart';
import 'package:jual_buku/controllers/auth_controller.dart';
import 'package:jual_buku/models/user_model.dart';
import 'package:jual_buku/pages/auth/register_page.dart';
import 'package:jual_buku/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      UserModel user = await _authController.login(
        username: username,
        password: password,
      );

      // Navigasi ke halaman beranda dengan mengirimkan data user
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: user),
        ),
      );
    } catch (e) {
      // Menampilkan pesan kesalahan jika gagal login
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _goToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Mengatur warna latar belakang halaman menjadi putih
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  'assets/images/logo.png'), // Menambahkan gambar logo login
              SizedBox(height: 32.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
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
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.blue, // Mengatur warna latar tombol menjadi biru
                  onPrimary: Colors
                      .white, // Mengatur warna teks pada tombol menjadi putih
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: _goToRegisterPage,
                child: Text(
                  'Belum punya akun? Daftar disini',
                  style: TextStyle(
                      color: Colors.blue), // Mengatur warna teks menjadi biru
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
