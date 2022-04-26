import 'package:dio/dio.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/nurse_models/v_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class NurseService {
  

  Future<DailyMenu> getDailyMenu(DateTime date) async {

    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/multiMenu/getMenuKin?timestamp=${date.millisecondsSinceEpoch}",
        options: AuthService.option,
      );
      Future.delayed(const Duration(seconds: 2), () {
      });
      return DailyMenu.fromJson(res.data);
    } catch (e) {
      throw Exception("Daily Menu Service: " + e.toString());
    }
  }

  Future<ResModel> enterDailyChildrenNumber(List<AgeGroupIdAndNumber> v) async {
    await Future.delayed(const Duration(seconds: 1), () {
    });
    try {
      var res = await Dio().post(
        "${AuthService.localhost}/out/api/perDay",
        data: {
          "numberOfChildrenDTOList": [v]
        },
        options: AuthService.option,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("Enter Number Of Children: " + e.toString());
    }
  }

  Future<NumberOfChildren> getDailyChildrenNumber(DateTime date) async {
    NumberOfChildren data;
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/perDay?timestamp=${date.millisecondsSinceEpoch}",
        options: AuthService.option,
      );
      data = NumberOfChildren.fromJson(res.data);
      return data;
    } catch (e) {
      throw Exception("getChildrenNumber: " + e.toString());
    }
  }

  Future<ResModel> editDailyChildrenNumber(
      List<AgeGroupIdAndNumber> v, num gardenId) async {
    try {
      Response res = await Dio().patch(
        "${AuthService.localhost}/out/api/perDay/$gardenId",
        data: {"numberOfChildrenDTOList": v},
        options: AuthService.option,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("Edit Number Of Children: " + e.toString());
    }
  }
}
