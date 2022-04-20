import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/hamshira_models/daily_menu_model.dart';
import 'package:governess/models/hamshira_models/number_of_children_dto_list_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/models/hamshira_models/number_of_children_model.dart';
import 'package:governess/models/hamshira_models/v_model.dart';
import 'package:governess/services/auth_service.dart';

class NurseService {
  Options option = Options(headers: {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJyb2xlcyI6IlJPTEVfSEFNU0hJUkEiLCJzdWIiOiJ4YW1zaGlyYW4zIiwiaWF0IjoxNjUwNDQwMTUyLCJleHAiOjE2NTEzMDQxNTJ9.bW1aTil0Lw1FDBqc8EUwfWEzgniTt3wODiNIvLEYi6g"
  });

  Future<DailyMenu> getDailyMenu(DateTime date) async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/multiMenu/getMenuKin?timestamp=${date.millisecondsSinceEpoch}",
        options: option,
      );

      return DailyMenu.fromJson(res.data);
    } catch (e) {
      throw Exception("Daily Menu Service: " + e.toString());
    }
  }

  Future<ResModel> enterDailyChildrenNumber(List<AgeGroupIdAndNumber> v) async {
    try {
      debugPrint(v[0].number.toString());
      var res = await Dio().post(
        "http://64.227.134.50:7788/out/api/perDay",
        data: {
          "numberOfChildrenDTOList": [v]
        },
        options: option,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("Enter Number Of Children: " + e.toString());
    }
  }

  Future<NumberOfChildren> getChildrenNumber() async {
    try {
      Response res = await Dio()
          .get("${AuthService.localhost}/out/api/perDay", options: option);
      return NumberOfChildren.fromJson(res.data);
    } catch (e) {
      throw Exception("getChildrenNumber: " + e.toString());
    }
  }

  Future<ResModel> editDailyChildrenNumber(NOCDL v,num menuId) async {
    try {
      Response res = await Dio().patch(
        "http://${AuthService.localhost}/out/api/perDay/$menuId",
        data: v,
        options: option,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("Edit Number Of Children: " + e.toString());
    }
  }
}
