import 'package:dio/dio.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class ManagerService {
  Future<ResModel> submitDailyNumberOfChildren(int kinderGardenId) async {

    try {
      Response res = await Dio().put(
        "${AuthService.localhost}/out/api/perDay/change/$kinderGardenId",
        options: Options(headers: {
      "Authorization":  Boxes.getUser().values.first.token,
    }),
      );
      return ResModel.fromJson(res.data);
    }  on DioError catch (e) {
      return ResModel(object: {},text: e.message,success: false,);
    }
  }

  Future<ResModel> submitDailyMenu(int id) async {
  
    try {
      Response res = await Dio().put(
        "${AuthService.localhost}/out/api/menu/confirmationMenu/$id",
        options:  Options(headers: {
      "Authorization":  Boxes.getUser().values.first.token,
    }),
      );
      return ResModel.fromJson(res.data);
    }  on DioError catch (e) {
      return ResModel.fromJson(e.response!.data);
    }
  }
}
