import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:governess/models/nurse_models/age_group_model.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/nurse_models/enter_number_of_children_page_data_model.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/nurse_models/age_group_id_and_number_model.dart';
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

  Future<ResModel> enterDailyChildrenNumber(
      List<AgeGroupIdAndNumber> v, DateTime date) async {
    try {
      var res = await Dio().post(
        "${AuthService.localhost}/out/api/perDay?date=${date.millisecondsSinceEpoch}",
        data: {"numberOfChildrenDTOList": v},
        options: AuthService.option,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("Enter Number Of Children: " + e.toString());
    }
  }

  Future<NumberOfChildren> getDailyChildrenNumber(DateTime date) async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/perDay?date=${date.millisecondsSinceEpoch}",
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
    } catch (e) {
      throw Exception(
          "NurseService / Edit Number Of Children: " + e.toString());
    }
  }

  Future<List<NurseEnterNumberChildrenPageData>> getAgeGroupList() async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/ageGroup",
        options: AuthService.option,
      );
      List<AgeGroup> data =
          (res.data as List).map((e) => AgeGroup.fromJson(e)).toList();
      return List.generate(
        data.length,
        (__) => NurseEnterNumberChildrenPageData(
          ageGroupIdAndNumber: data[__],
          controller: TextEditingController(),
          idf: false,
          nodes: FocusNode(),
        ),
      );
    } catch (e) {
      throw Exception("NurseService / getAgeGroupList" + e.toString());
    }
  }
}
