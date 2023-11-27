class FaqModel {
  int id;
  String pertanyaan;
  String jawaban;
  String createdAt;
  String updatedAt;

  FaqModel({
    required this.id,
    required this.pertanyaan,
    required this.jawaban,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'],
      pertanyaan: json['pertanyaan'],
      jawaban: json['jawaban'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
