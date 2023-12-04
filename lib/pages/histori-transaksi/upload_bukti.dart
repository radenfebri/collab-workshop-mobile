import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jual_buku/models/transaksi_model.dart';
import 'package:jual_buku/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadBuktiPage extends StatefulWidget {
  final Transaksi transaksi;

  UploadBuktiPage({required this.transaksi});

  @override
  _UploadBuktiPageState createState() => _UploadBuktiPageState();
}

class _UploadBuktiPageState extends State<UploadBuktiPage> {
  final ImagePicker _picker = ImagePicker();
  File? uploadimage;

  Future<void> chooseImage() async {
    var choosedimage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  Future<void> uploadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/pesanan/upload-bukti'));

      request.headers['Authorization'] = 'Bearer $token';
      request.files
          .add(await http.MultipartFile.fromPath('bukti', uploadimage!.path));
      request.fields['id'] = widget.transaksi.id.toString();

      var response = await request.send();
      if (response.statusCode == 200) {
        showSuccessDialog();
      } else {
        showErrorDialog(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Upload Bukti Bayar"),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: widget.transaksi.bukti != null || uploadimage != null
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 300.0,
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
                            child: widget.transaksi.bukti != null &&
                                    uploadimage == null
                                ? Image.network(
                                    'https://tukubuku.galeriketutsjember.com/storage/' +
                                        widget.transaksi.bukti!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    uploadimage!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      )
                    : Container()),
            Container(
                child: uploadimage == null
                    ? Container()
                    : ElevatedButton.icon(
                        onPressed: () {
                          uploadImage();
                        },
                        icon: const Icon(Icons.file_upload),
                        label: const Text("UPLOAD"),
                      )),
            ElevatedButton.icon(
              onPressed: () {
                chooseImage();
              },
              icon: const Icon(Icons.folder_open),
              label: const Text("CARI BUKTI"),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSuccessDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Berhasil Upload',
      desc: 'Harap Tunggu Konfirmasi Pembayaran',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
      width: MediaQuery.of(context).size.width * 0.7,
    )..show();
  }

  void showErrorDialog(msg) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Gagal Upload',
      desc: msg,
      btnOkOnPress: () {
        Navigator.pop(context);
      },
      width: MediaQuery.of(context).size.width * 0.7,
    )..show();
  }
}
