import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:governess/local_storage/user_storage.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/models/user/user_model.dart';

class AuthService {                
 static  String localhost = "http://185.217.131.117:7788";
  Future<ResModel> signUpUser(bool success) async {
    try {
      return ResModel(
          text: "Arizangiz muvaffaqiyatli yuborildi",
          success: success,
          object: null);
    } catch (e) {
      throw Exception("Auth Service applyAsUser: " + e.toString());
    }
  }

  Future<User> getUser(String login, String password) async {
    Response user;
    User decodedUser;

    try {
      user = await Dio().post(
        "${AuthService.localhost}/out/api/user/signIn",
        data: {"login": login, "password": password},
      );
      decodedUser = User.fromJson(user.data);

      await UserHive().addUser(
        id: decodedUser.id,
        fatherName: decodedUser.fatherName,
        name: decodedUser.name,
        role: decodedUser.role,
        success: decodedUser.success,
        surname: decodedUser.surname,
        token: decodedUser.token,
        username: decodedUser.username,
      );
      return decodedUser;
    } catch (e) {
      throw Exception("Getting User:::" + e.toString());
    }
  }
}
