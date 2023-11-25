class MetodePembayaran {
  int id;
  String noRek;
  String atasNama;
  String namaBank;
  String createdAt;
  String updatedAt;

  MetodePembayaran({
    required this.id,
    required this.noRek,
    required this.atasNama,
    required this.namaBank,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MetodePembayaran.fromJson(Map<String, dynamic> json) {
    return MetodePembayaran(
      id: json['id'],
      noRek: json['no_rek'],
      atasNama: json['atas_nama'],
      namaBank: json['nama_bank'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
