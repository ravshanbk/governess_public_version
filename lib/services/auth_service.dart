import 'package:dio/dio.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/local_storage/user_storage.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/models/user/change_user_info.dart';
import 'package:governess/models/user/user_model.dart';

class AuthService {
  static Options option = Options(headers: {
    "Authorization": Boxes.getUser().values.first.token,
  });
  static String localhost = "http://185.217.131.117:7788";
  // static String localhost = "http://192.168.68.110:7788";

  Future<bool> getUser(String login, String password) async {
    User decodedUser;

    try {
      Response user = await Dio().post(
        "${AuthService.localhost}/out/api/user/signIn",
        data: {"login": login, "password": password},
      );
      if (user.statusCode == 200) {
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

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<ResModel> changeLoginPassword({required ChangUserInfo info}) async {
    try {
      Response res = await Dio().patch(
        "${AuthService.localhost}/out/api/user",
        options: Options(
          headers: {
            "Authorization": Boxes.getUser().values.first.token,
          },
        ),
        data: {
          "newPassword": info.newPassword,
          "oldPassword": info.oldPassword,
          "username": info.username
        },
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("AuthService / changeLoginPassword" + e.toString());
    }
  }
}
