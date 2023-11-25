class Transaksi {
  final int id;
  final String namaUser;
  final String namaBuku;
  final String name;
  final String email;
  final int status;
  final String metode;
  final String trackingNo;
  final String totalPrice;
  final String noRek;
  final String atasNama;

  Transaksi({
    required this.id,
    required this.namaUser,
    required this.name,
    required this.email,
    required this.status,
    required this.metode,
    required this.trackingNo,
    required this.totalPrice,
    required this.namaBuku,
    required this.noRek,
    required this.atasNama,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id'],
      namaUser: json['nama_user'],
      namaBuku: json['name_buku'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      metode: json['nama_bank'],
      noRek: json['no_rek'],
      atasNama: json['atas_nama'],
      trackingNo: json['tracking_no'],
      totalPrice: json['total_price'].toString(),
    );
  }
}
