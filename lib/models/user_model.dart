class UserModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? token;

// constructor nya
  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.token,
  });

  // contructor bila data dari json
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    token = json['token'];
  }

  // buat function untuk mengubah fungsi diatas ke dalam bentuk json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'token': token,
    };
  }
}
