import 'package:dio/dio.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/nurse_models/age_group_model.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/nurse_models/age_group_id_and_number_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class NurseService {
  Future<DailyMenu> getDailyMenu(DateTime date) async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/multiMenu/getMenuKin?timestamp=${date.millisecondsSinceEpoch}",
        options: AuthService.option,
      );
      Future.delayed(const Duration(seconds: 2), () {});
      return DailyMenu.fromJson(res.data);
    } catch (e) {
      throw Exception("Daily Menu Service: " + e.toString());
    }
  }

  Future<ResModel> enterDailyChildrenNumber({
    required List<AgeGroupIdAndNumber> v,
    required DateTime date,
    required int kGId,
  }) async {
    p(date.millisecondsSinceEpoch);
    p(DTFM.maker(date.millisecondsSinceEpoch));
    try {
      Response res = await Dio().post(
        "${AuthService.localhost}/out/api/perDay?date=${date.millisecondsSinceEpoch}",
        options: AuthService.option,
        data: {
          "kindergartenId": kGId,
          "numberOfChildrenDTOList": v,
        },
      );
      return ResModel.fromJson(res.data);
    } on DioError catch (e) {
      return ResModel.fromJson(e.response!.data);
    }
  }

  Future<NumberOfChildren> getDailyChildrenNumber(DateTime date) async {
    DateTime thisDay = DateTime(date.year, date.month, date.day);
    // p("GEt daily childrenPage: " + thisDay.millisecondsSinceEpoch.toString());
    // p("GEt daily childrenPage: " + thisDay.microsecondsSinceEpoch.toString());
    // p("GEt daily childrenPage: " + DTFM.maker(thisDay.millisecondsSinceEpoch));
    // p("GEt daily childrenPage: " + thisDay.timeZoneName);
    int mixedDate = thisDay.millisecondsSinceEpoch + 18000001;

    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/perDay?date=$mixedDate",
        options: AuthService.option,
      );
      return NumberOfChildren.fromJson(res.data);
    } catch (e) {
      throw Exception("getChildrenNumber: " + e.toString());
    }
  }

  Future<ResModel> changeDailyChildrenNumber(
      List<AgeGroupIdAndNumber> v, int gardenId) async {
    try {
      Response res = await Dio().patch(
        "${AuthService.localhost}/out/api/perDay/$gardenId",
        data: {"numberOfChildrenDTOList": v},
        options: AuthService.option,
      );
      return ResModel.fromJson(res.data);
    } on DioError catch (e) {
      return ResModel.fromJson(e.response!.data);
    }
  }

  Future<List<AgeGroup>> getAgeGroupList() async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/ageGroup",
        options: AuthService.option,
      );

      return (res.data as List).map((e) => AgeGroup.fromJson(e)).toList();
    } catch (e) {
      throw Exception("NurseService / getAgeGroupList" + e.toString());
    }
  }
}
