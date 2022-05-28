import 'package:dio/dio.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/nurse_models/age_group_model.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class NurseService {
  Future<DailyMenu> getDailyMenu(DateTime date) async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/multiMenu/getMenuKin?date=${date.millisecondsSinceEpoch}",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );
      Future.delayed(const Duration(seconds: 2), () {});
      DailyMenu d = DailyMenu.fromJson(res.data);
      return d;
    } catch (e) {
      throw Exception("Daily Menu Service: " + e.toString());
    }
  }

  Future<ResModel> enterDailyChildrenNumber({
    required FormData formData,
    required DateTime date,
  }) async {
     try {
      Response res = await Dio().post(
        "${AuthService.localhost}/out/api/perDay?date=${date.millisecondsSinceEpoch}",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
        data: formData,
      );
      return ResModel.fromJson(res.data);
    } on DioError catch (e) {
      return ResModel(
          success: false, object: {}, text: e.response!.data.toString());
    }
  }

  Future<NumberOfChildren> getDailyChildrenNumber(DateTime date) async {
    DateTime thisDay = DateTime(date.year, date.month, date.day);
    int mixedDate = thisDay.millisecondsSinceEpoch + 18000001;
     try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/perDay?date=$mixedDate",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );
      return NumberOfChildren.fromJson(res.data);
      // return NumberOfChildren(
      //   district: District(id: 1, name: ""),
      //   perDayList: List.generate(
      //     4,
      //     (index) => PerDayList(
      //       status: "",
      //       updateBy: 12,
      //       updateDate: 1,
      //       createDate: 23423,
      //       createdBy: 234,
      //       id: 1,
      //       kindergartenId: 1,
      //       kindergartenName: "",
      //       numberOfChildrenDtoList: List.generate(
      //         4,
      //         (index) => NumberOfChildrenDtoList(
      //           ageGroupId: 1,
      //           ageGroupName: "",
      //           createDate: 12,
      //           id: 1,
      //           number: 1,
      //           updateDate: 12,
      //         ),
      //       ),
      //     ),
      //   ),
      // );
    } catch (e) {
      throw Exception("getChildrenNumber: " + e.toString());
    }
  }

  Future<ResModel> changeDailyChildrenNumber(
      FormData formData, int gardenId) async {
    try {
      Response res = await Dio().patch(
        "${AuthService.localhost}/out/api/perDay/$gardenId",
        data: formData,
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
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
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );

      return (res.data as List).map((e) => AgeGroup.fromJson(e)).toList();
    } catch (e) {
      throw Exception("NurseService / getAgeGroupList" + e.toString());
    }
  }
}
