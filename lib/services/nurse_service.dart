import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/nurse_models/v_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class NurseService {
  Options option = Options(headers: {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJyb2xlcyI6IlJPTEVfSEFNU0hJUkEiLCJzdWIiOiJiMmhhbXNoaXJhIiwiaWF0IjoxNjUwNTQ3NDI4LCJleHAiOjE2NTE0MTE0Mjh9.BsFgihXP9iLc0mOMq5Oa_WzhFvm7MSSFS7iPvaCkacM"
  });

  Future<DailyMenu> getDailyMenu(DateTime date) async {
    p(date.millisecondsSinceEpoch.toString());

    try {
      Response res = await Dio().get(
        "http://192.168.68.107:7788/out/api/multiMenu/getMenuKin?timestamp=1650609741634",
        options: option,
      );
      Future.delayed(const Duration(seconds: 2), () {
        p(res.data.toString());
      });
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

  Future<ResModel> editDailyChildrenNumber(
      List<AgeGroupIdAndNumber> v, num gardenId) async {
    try {
      Response res = await Dio().patch(
        "http://${AuthService.localhost}/out/api/perDay/$gardenId",
        data: {"numberOfChildrenDTOList": v},
        options: option,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("Edit Number Of Children: " + e.toString());
    }
  }
}
