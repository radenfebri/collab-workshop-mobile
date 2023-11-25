import 'package:flutter/material.dart';
import 'package:jual_buku/controllers/auth_controller.dart';
import 'package:jual_buku/models/user_model.dart';
import 'package:jual_buku/pages/buku/buku_page.dart';
import 'package:jual_buku/pages/histori-transaksi/histori_page.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = AuthController();

  void _logout(BuildContext context) async {
    if (!mounted) {
      return; // Widget sudah tidak aktif, hentikan proses logout
    }

    try {
      await authController.logout(
          context); // Panggil metode logout dari AuthController dengan meneruskan context
    } catch (e) {
      print('Failed to logout: $e');
      // Tampilkan pesan atau lakukan tindakan jika gagal logout
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
                _logout(context); // Panggil fungsi logout
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.name ?? ''),
              accountEmail: Text(widget.user.email ?? ''),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Cari Buku'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BukuPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Histori Transaksi'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoriTransaksiPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
