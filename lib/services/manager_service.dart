import 'package:dio/dio.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class ManagerService {
  Options option = Options(headers: {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJyb2xlcyI6IlJPTEVfQk9HYENIQSBNVURJUkFTSSIsInN1YiI6ImIybXVkaXJhIiwiaWF0IjoxNjUwNzA4ODgwLCJleHAiOjE2NTE1NzI4ODB9.ZTEkjFGHTF-1TbSjhbcfd4_8pEjsa18hro1VN2g_3nIBearer eyJhbGciOiJIUzI1NiJ9.eyJyb2xlcyI6IlJPTEVfQk9HYENIQSBNVURJUkFTSSIsInN1YiI6ImIybXVkaXJhIiwiaWF0IjoxNjUwNzA4ODgwLCJleHAiOjE2NTE1NzI4ODB9.ZTEkjFGHTF-1TbSjhbcfd4_8pEjsa18hro1VN2g_3nI"
  });

  Future<ResModel> submitDailyNumberOfChildren(int kinderGardenId) async {
    try {
      Response res = await Dio().put(
        "${AuthService.localhost}/out/api/perDay/change/$kinderGardenId",
        options: option,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("ManagerService / submitDailyMenyu: " + e.toString());
    }
  }

  Future<ResModel> submitDailyMenu(num id) async {
    try {
      Response res = await Dio().put(
          "${AuthService.localhost}/out/api/menu/confirmationMenu/$id",
          options: option);
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("ManagerService / submitDailyMenu: " + e.toString());
    }
  }
}
