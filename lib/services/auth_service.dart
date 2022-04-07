import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:governess/local_storage/user_storage.dart';
import 'package:governess/models/other/place_user.dart';
import 'package:governess/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  Future<User> getUser(String login, String password) async {
    Response user;
    User decodedUser;

    try {

      user = await Dio().post(
        "http://64.227.134.50:7788/out/api/user/signIn",
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

    } catch (e) {
      throw Exception("Getting User:::" + e.toString());
    }

    return decodedUser;
  }

  Future<User> getUserHttp(String login, String password) async {
    debugPrint(login);
    debugPrint(password);

   var response;
    User decodedUser;
    try {
      var url = Uri.parse("http://64.227.134.50:7788/out/api/user/signIn");

      response =
          await http.post(url, body: {"login": login, "password": password});
    debugPrint("body::: "+response.body);
    debugPrint("headers::: "+response.headers.toString());

      decodedUser =  User.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception("Http Service::" + e.toString());
    }
    debugPrint(decodedUser.name.toString());
    return decodedUser;
  }

  jsonPleaseHolderExample() async {
    debugPrint("Json ga kirdi");
    http.Response response;
    UserPlace decodedUser;
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/users/1");

      response = await http.get(url);
      debugPrint(response.body.toString());

      decodedUser = UserPlace.fromJson(response.headers);
      debugPrint(decodedUser.name);
    } catch (e) {
      throw Exception("Http Service" + e.toString());
    }
    return decodedUser;
  }
}
