import 'package:flutter/material.dart';

class DetailBayar extends StatefulWidget {
  final Map<String, dynamic> pesanan;
  final Map<String, dynamic> buku;
  final Map<String, dynamic> bank;

  const DetailBayar({
    required this.pesanan,
    required this.buku,
    required this.bank,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailBayar> createState() => _DetailBayarState();
}

class _DetailBayarState extends State<DetailBayar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pembayaran'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pesanan:',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'User ID: ${widget.pesanan['user_id']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Buku ID: ${widget.pesanan['buku_id']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Nama: ${widget.pesanan['name']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Email: ${widget.pesanan['email']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Status: ${widget.pesanan['status']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Metode Pembayaran: ${widget.pesanan['metode']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Tracking No: ${widget.pesanan['tracking_no']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Total Pembayaran: ${widget.pesanan['total_price']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Updated At: ${widget.pesanan['updated_at']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Created At: ${widget.pesanan['created_at']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'ID: ${widget.pesanan['id']}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 24.0),
          Text(
            'Buku:',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'ID: ${widget.buku['id']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Nama: ${widget.buku['name']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Deskripsi: ${widget.buku['description']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Image.network(
            widget.buku['cover'],
            height: 200.0,
            width: 200.0,
          ),
          SizedBox(height: 24.0),
          Text(
            'Bank:',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'ID: ${widget.bank['id']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Atas Nama: ${widget.bank['atas_nama']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Nama Bank: ${widget.bank['nama_bank']}',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Nomor Rekening: ${widget.bank['no_rek']}',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
