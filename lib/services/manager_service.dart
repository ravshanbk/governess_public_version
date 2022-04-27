import 'package:dio/dio.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class ManagerService {
  Future<ResModel> submitDailyNumberOfChildren(int kinderGardenId) async {
    try {
      Response res = await Dio().put(
        "${AuthService.localhost}/out/api/perDay/change/$kinderGardenId",
        options: AuthService.option,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("ManagerService / submitDailyMenyu: " + e.toString());
    }
  }

  Future<ResModel> submitDailyMenu(int id) async {
    p(id.toString());
    try {
      Response res = await Dio().put(
        "${AuthService.localhost}/out/api/menu/confirmationMenu/$id",
        options: AuthService.option,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("ManagerService / submitDailyMenu: " + e.toString());
    }
  }
}
