import 'package:flutter/material.dart';
import 'package:jual_buku/models/user_model.dart';
import 'package:jual_buku/pages/auth/login_page.dart';
import 'package:jual_buku/pages/auth/register_page.dart';
import 'package:jual_buku/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuku Buku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final UserModel user = settings.arguments as UserModel;
          return MaterialPageRoute(
            builder: (context) => HomePage(user: user),
          );
        }
        return null;
      },
    );
  }
}
