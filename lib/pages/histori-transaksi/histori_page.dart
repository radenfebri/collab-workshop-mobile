import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jual_buku/controllers/transaksi_controller.dart';
import 'package:jual_buku/models/transaksi_model.dart';
import 'package:jual_buku/services/currency_format.dart';

class HistoriTransaksiPage extends StatefulWidget {
  @override
  _HistoriTransaksiPageState createState() => _HistoriTransaksiPageState();
}

class _HistoriTransaksiPageState extends State<HistoriTransaksiPage> {
  TransactionController _transactionController = TransactionController();
  List<Transaksi> _transactions = [];
  int decimalDigit = 0;

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    try {
      List<Transaksi> transactions =
          await _transactionController.fetchTransactions();
      setState(() {
        _transactions = transactions;
      });
    } catch (error) {
      print('Terjadi kesalahan: $error');
      // Tampilkan pesan kesalahan kepada pengguna
    }
  }

  String getStatusText(int status) {
    if (status == 0) {
      return 'Diproses';
    } else if (status == 1) {
      return 'Berhasil';
    } else {
      return 'Status tidak diketahui';
    }
  }

  Color getStatusColor(int status) {
    if (status == 0) {
      return Colors.red;
    } else if (status == 1) {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  void _showHistoriDetail(int index) {
    Transaksi transaksi = _transactions[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Detail Histori Transaksi',
                  style: GoogleFonts.poppins()),
              content: Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // Lebar dialog menjadi 80% dari lebar layar
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Nomor Tracking: ${transaksi.trackingNo}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Total Harga:'),
                    Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                            CurrencyFormat.convertToIdr(
                                int.parse(transaksi.totalPrice), decimalDigit),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: transaksi.totalPrice));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Total Harga disalin')),
                            );
                          },
                        ),
                      ],
                    ),
                    Text('Status Histori: ${getStatusText(transaksi.status)}'),
                    SizedBox(height: 16),
                    Text('Informasi Pembayaran:'),
                    Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                              'Nomor Rekening: ${transaksi.noRek}'),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: transaksi.noRek));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Nomor Rekening disalin')),
                            );
                          },
                        ),
                      ],
                    ),
                    Text('Bank Tujuan: ${transaksi.metode}'),
                    Text('Atas Nama: ${transaksi.atasNama}'),
                    SizedBox(height: 16),
                    Text(
                      'Catatan:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Transfer harus sesuai dengan nominal yang tertera.'),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0), // Mengatur padding konten dialog
              actions: [
                if (transaksi.status ==
                    0) // Hanya tampilkan tombol jika status "Diproses"
                  ElevatedButton(
                    child: Text('Batalkan', style: GoogleFonts.poppins()),
                    onPressed: () async {
                      Navigator.pop(context);
                      // Tampilkan dialog konfirmasi pembatalan
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.bottomSlide,
                        title: 'Konfirmasi Pembatalan',
                        desc:
                            'Apakah Anda yakin ingin membatalkan transaksi ini?',
                        btnCancelText: 'Batal',
                        btnCancelOnPress: () async {
                          try {
                            await _transactionController
                                .deleteTransaction(transaksi.id);
                            await _fetchTransactions();
                            setState(() {});
                          } catch (error) {
                            print('Error: $error');
                          }
                        },
                        btnOkText: 'OK',
                        btnOkOnPress: () async {
                          // Hapus transaksi setelah konfirmasi
                          await _transactionController
                              .deleteTransaction(transaksi.id);
                          await _fetchTransactions();
                          setState(() {});
                        },
                        width: MediaQuery.of(context).size.width * 0.7,
                      )..show();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ElevatedButton(
                  child: Text('Tutup', style: GoogleFonts.poppins()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF177DFF),
        title: Text('Histori Transaksi', style: GoogleFonts.poppins()),
      ),
      body: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          Transaksi transaksi = _transactions[index];
          Color statusColor = getStatusColor(transaksi.status);
          return Card(
            color: statusColor,
            child: ListTile(
              title: Text(
                'No Tracking: ${transaksi.trackingNo}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Harga: ${CurrencyFormat.convertToIdr(int.parse(transaksi.totalPrice), decimalDigit)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  Text(
                    'Status Histori: ${getStatusText(transaksi.status)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ],
              ),
              onTap: () {
                _showHistoriDetail(index);
              },
            ),
          );
        },
      ),
    );
  }
}
