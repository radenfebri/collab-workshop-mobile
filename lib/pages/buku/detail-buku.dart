import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jual_buku/models/buku_model.dart';
import 'package:jual_buku/pages/pembayaran/pembayaran_page.dart';
import 'package:jual_buku/services/currency_format.dart';

class DetailBukuPage extends StatelessWidget {
  final Buku buku;
  int decimalDigit = 2;

  DetailBukuPage({required this.buku});

  @override
  Widget build(BuildContext context) {
    bool isStockAvailable = int.parse(buku.qty) > 0;

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
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      buku.cover,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                buku.name,
                style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                buku.sellingPrice != null
                    ? CurrencyFormat.convertToIdr(
                        int.parse(buku.sellingPrice!), decimalDigit)
                    : CurrencyFormat.convertToIdr(
                        int.parse(buku.originalPrice), decimalDigit),
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Tersedia: ${buku.qty.toString()}',
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Deskripsi:',
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                buku.description.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: isStockAvailable
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PembayaranPage(
                              buku: buku,
                            ),
                          ),
                        );
                      }
                    : null,
                child: Text('Lanjut Pembayaran'),
                style: ElevatedButton.styleFrom(
                  textStyle: GoogleFonts.poppins(fontSize: 16.0),
                  onSurface: isStockAvailable ? null : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
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
