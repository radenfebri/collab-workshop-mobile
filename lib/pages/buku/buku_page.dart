import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jual_buku/controllers/buku_controller.dart';
import 'package:jual_buku/models/buku_model.dart';
import 'package:jual_buku/pages/buku/detail-buku.dart';

class BukuPage extends StatefulWidget {
  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  final BukuController bukuController = BukuController();
  final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
  late Future<List<Buku>> bukuListFuture;

  @override
  void initState() {
    super.initState();
    bukuListFuture = bukuController.getBukuList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Buku'),
      ),
      body: FutureBuilder<List<Buku>>(
        future: bukuListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to fetch data'),
            );
          } else if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final buku = snapshot.data![index];
                return BukuCard(buku: buku);
              },
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}

class BukuCard extends StatelessWidget {
  final Buku buku;

  BukuCard({required this.buku});

  void navigateToDetailPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailBukuPage(buku: buku)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: GestureDetector(
        onTap: () => navigateToDetailPage(
            context), // Navigasi ke halaman detail saat diklik
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image.network(
                  buku.cover,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    buku.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    buku.sellingPrice != null
                        ? 'Rp. ${buku.sellingPrice!}'
                        : 'Rp. ${buku.originalPrice}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Tersedia: ${buku.qty.toString()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
