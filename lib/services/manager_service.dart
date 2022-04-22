import 'package:dio/dio.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class ManagerService {
  Future<ResModel> submitDailyNumberOfChildren() async {
    try {
      Response res =
          await Dio().put("${AuthService.localhost}/out/api/perDay/change");
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("ManagerService / submitDailyMenyu: " + e.toString());
    }
  }

  Future<ResModel> submitDailyMenu(num id) async {
    try {
      Response res = await Dio()
          .put("${AuthService.localhost}/out/api/menu/confirmationMenu/$id");
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("ManagerService / submitDailyMenu: " + e.toString());
    }
  }
}
