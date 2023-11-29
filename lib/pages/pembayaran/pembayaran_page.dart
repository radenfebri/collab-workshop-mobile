import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jual_buku/controllers/bank_controller.dart';
import 'package:jual_buku/controllers/transaksi_controller.dart';
import 'package:jual_buku/models/bank_model.dart';
import 'package:jual_buku/models/buku_model.dart';
import 'package:jual_buku/pages/histori-transaksi/histori_page.dart';
import 'package:jual_buku/services/currency_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PembayaranPage extends StatefulWidget {
  final Buku buku;

  PembayaranPage({required this.buku});

  @override
  _PembayaranPageState createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  List<MetodePembayaran> banks = [];
  MetodePembayaran? selectedBank;
  String? token;
  int decimalDigit = 0;

  @override
  void initState() {
    super.initState();
    fetchBanks();
    getToken();
  }

  Future<void> fetchBanks() async {
    try {
      List<MetodePembayaran> fetchedBanks = await BankController.fetchBanks();
      setState(() {
        banks = fetchedBanks;
      });
    } catch (error) {
      // Handle error
      print('Failed to fetch banks: $error');
    }
  }

  Future<void> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF177DFF),
        title: Text('Pembayaran',
            style: GoogleFonts.poppins()), // Menggunakan Google Fonts
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Buku yang di checkout:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(widget.buku.name),
            subtitle: Text(
              widget.buku.sellingPrice != null
                  ? 'Harga: ${CurrencyFormat.convertToIdr(int.parse(widget.buku.sellingPrice!), decimalDigit)}'
                  : 'Harga: ${CurrencyFormat.convertToIdr(int.parse(widget.buku.originalPrice), decimalDigit)}',
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Metode Pembayaran:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: banks.length,
                        itemBuilder: (context, index) {
                          MetodePembayaran bank = banks[index];
                          return ListTile(
                            title: Text(' Bank ${bank.namaBank}',
                                style: GoogleFonts.poppins()),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'No. Rek: ${bank.noRek}',
                                  style: GoogleFonts.poppins(),
                                ),
                                Text(
                                  'Nama: ${bank.atasNama}',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                selectedBank = bank;
                              });
                            },
                            tileColor:
                                selectedBank == bank ? Colors.blue : null,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF177DFF),
                        textStyle: GoogleFonts.poppins(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 24.0),
                        elevation: 4.0,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      onPressed: selectedBank != null ? lanjutPembayaran : null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.payment, size: 24.0),
                          SizedBox(width: 8.0),
                          Text(
                            'Lanjutkan Pembayaran',
                            style: GoogleFonts.poppins(),
                          ),
                        ],
                      ),
                    ),
                  ])),
        ],
      ),
    );
  }

  void lanjutPembayaran() {
    if (token != null && selectedBank != null) {
      TransactionController transaction = new TransactionController();
      transaction
          .storeTransaction(widget.buku.id, selectedBank!.id)
          .then((data) => {
                if (data.statusCode == 200)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoriTransaksiPage()),
                    )
                  }
                else
                  {print(data.body)}
              });
    }
  }
}
