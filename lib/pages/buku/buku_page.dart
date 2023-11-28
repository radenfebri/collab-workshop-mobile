import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jual_buku/controllers/buku_controller.dart';
import 'package:jual_buku/models/buku_model.dart';
import 'package:jual_buku/pages/buku/detail-buku.dart';
import 'package:jual_buku/services/currency_format.dart';

class BukuPage extends StatefulWidget {
  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  final BukuController bukuController = BukuController();
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
  int decimalDigit = 0;

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
        onTap: () => navigateToDetailPage(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140.0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.network(
                    buku.cover,
                    fit: BoxFit.cover,
                    width: 120.0,
                    height: 120.0,
                  ),
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
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    buku.sellingPrice != null
                        ? CurrencyFormat.convertToIdr(
                            int.parse(buku.sellingPrice!), decimalDigit)
                        : CurrencyFormat.convertToIdr(
                            int.parse(buku.originalPrice), decimalDigit),
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Tersedia: ${buku.qty.toString()}',
                    style: GoogleFonts.poppins(
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
