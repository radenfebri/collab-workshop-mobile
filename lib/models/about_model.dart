class AboutModel {
  String text;

  AboutModel({
    required this.text,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      text: json['text'] ?? '',
    );
  }
}
