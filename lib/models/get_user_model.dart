import 'package:governess/models/user/user_model.dart';

class GetUserModel {
  bool success;
  User user;
  String? text;
  GetUserModel({
    required this.success,
    required this.user,
    this.text
  });
}
