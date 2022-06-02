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

 
  Future<GetUserModel> getUser(String login, String password) async {
    User decodedUser;

    try {
      //   Response user = await Dio().post(
      //     "${AuthService.localhost}/out/api/user/signIn",
      //     data: {"login": login, "password": password},
      //   );

      //   decodedUser = User.fromJson(user.data);

      return GetUserModel(
        success: true,
        user: User(
          fatherName: "fatherName",
          id: 1,
          name: "name",
          role: "role",
          success: true,
          surname: "surname",
          token: "token",
          username: "username",
        ),
      );
    } on DioError catch (e) {
      return GetUserModel(
          success: false, user: User(), text: "Parol yoki login xato!");
    }
  }

  Future<ResModel> changeLoginPassword({required ChangUserInfo info}) async {
    try {
      // Response res = await Dio().patch(
      //   "${AuthService.localhost}/out/api/user",
      //   options: Options(
      //     headers: {
      //       "Authorization": Boxes.getUser().values.first.token,
      //     },
      //   ),
      //   data: {
      //     "newPassword": info.newPassword,
      //     "oldPassword": info.oldPassword,
      //     "username": info.username
      //   },
      // );
      // return ResModel.fromJson(res.data);
       return ResModel(object: {},success: true,text: "Muvafaqiyatli o'zgartirildi");

    } on DioError catch (e) {
      return ResModel.fromJson(e.response!.data);
    }
  }
}
