import 'package:flutter/material.dart';
import 'package:jual_buku/models/buku_model.dart';
import 'package:jual_buku/pages/pembayaran/pembayaran_page.dart';

class DetailBukuPage extends StatelessWidget {
  final Buku buku;

  DetailBukuPage({required this.buku});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  buku.cover,
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                buku.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                buku.sellingPrice != null
                    ? 'Harga: Rp. ${buku.sellingPrice!}'
                    : 'Harga: Rp. ${buku.originalPrice}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Tersedia: ${buku.qty.toString()}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Description: ${buku.description.toString()}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PembayaranPage(buku: buku),
                    ),
                  );
                },
                child: Text('Lanjut ke Detail Pembayaran'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
