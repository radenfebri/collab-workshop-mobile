import 'package:get/get.dart';

class User {
  final RxInt id;
  final RxString name;
  final RxString email;
  final RxString username;

  User({
    required int id,
    required String name,
    required String email,
    required String username,
  })  : id = id.obs,
        name = name.obs,
        email = email.obs,
        username = username.obs;
}
