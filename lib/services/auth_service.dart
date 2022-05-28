import 'package:dio/dio.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/get_user_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/models/user/change_user_info.dart';
import 'package:governess/models/user/user_model.dart';

class AuthService {
  static Options? optio0n = Options(headers: {
    "Authorization": Boxes.getUser().values.first.token,
  });

  // static String localhost = "http://185.217.131.117:7788";
  static String localhost = "http://192.168.250.54:7788";

  Future<GetUserModel> getUser(String login, String password) async {
    User decodedUser;
    print("${AuthService.localhost}/out/api/user/signIn");
    print({"login": login, "password": password});
    try {
      Response user = await Dio().post(
        "${AuthService.localhost}/out/api/user/signIn",
        data: {"login": login, "password": password},
      );

      decodedUser = User.fromJson(user.data);

      return GetUserModel(
        success: user.statusCode == 200,
        user: decodedUser,
      );
    } on DioError catch (e) {
      return GetUserModel(success: false, user: User(), text: e.message);
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
    } on DioError catch (e) {
      return ResModel.fromJson(e.response!.data);
    }
  }
}
