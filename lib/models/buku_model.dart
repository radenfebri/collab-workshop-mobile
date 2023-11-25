class Buku {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String originalPrice;
  final String? sellingPrice;
  final String cover;
  final String qty;
  final int popular;
  final String kategori;
  final KategoriBuku kategoriBuku;

  Buku({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.originalPrice,
    required this.sellingPrice,
    required this.cover,
    required this.qty,
    required this.popular,
    required this.kategori,
    required this.kategoriBuku,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      originalPrice: json['original_price'],
      sellingPrice: json['selling_price'],
      cover: json['cover'],
      qty: json['qty'],
      popular: json['popular'],
      kategori: json['kategori'],
      kategoriBuku: KategoriBuku.fromJson(json['kategoribuku']),
    );
  }
}

class KategoriBuku {
  final int id;
  final String name;

  KategoriBuku({
    required this.id,
    required this.name,
  });

  factory KategoriBuku.fromJson(Map<String, dynamic> json) {
    return KategoriBuku(
      id: json['id'],
      name: json['name'],
    );
  }
}
