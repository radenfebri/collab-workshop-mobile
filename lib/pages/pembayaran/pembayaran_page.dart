import 'package:flutter/material.dart';
import 'package:jual_buku/controllers/bank_controller.dart';
import 'package:jual_buku/controllers/transaksi_controller.dart';
import 'package:jual_buku/models/bank_model.dart';
import 'package:jual_buku/models/buku_model.dart';
import 'package:jual_buku/pages/histori-transaksi/histori_page.dart';
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
        title: Text('Pembayaran'),
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
                  ? 'Harga: Rp. ${widget.buku.sellingPrice!}'
                  : 'Harga: Rp. ${widget.buku.originalPrice}',
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Metode Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: banks.length,
              itemBuilder: (context, index) {
                MetodePembayaran bank = banks[index];
                return ListTile(
                  title: Text('Nama Bank: ${bank.namaBank}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No. Rekening: ${bank.noRek}'),
                      Text('Nama Pemilik: ${bank.atasNama}'),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      selectedBank = bank;
                    });
                  },
                  tileColor: selectedBank == bank ? Colors.blue : null,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: selectedBank != null ? lanjutPembayaran : null,
            child: Text('Lanjutkan Pembayaran'),
          ),
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
                  {
                    print(data.body)
                    //TODO Set Alert Gagal Checkout
                  }
              });
    }
  }
}
