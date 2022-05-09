import 'package:dio/dio.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/cooker/meal_info_model.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/cooker/receive_product_model.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';
import 'package:governess/models/cooker/waste_product_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class CookerService {
  Future<ResModel> acceptProduct(
      {required ReceiveProductModel data, required String id}) async {
    try {
      Response res = await Dio(BaseOptions()).put(
        "${AuthService.localhost}/out/api/cook/receive/$id",
        options: AuthService.option,
        data: data,
      );
      return ResModel.fromJson(res.data);
    } on DioError catch (e) {
      p("Dio Errror: " + e.response!.data.toString());
      return ResModel(
        success: false,
        text: "Nimadir hato bo'ldi",
        object: {},
      );
    }
  }

  Future<List<CookerProduct>> getInOutByDate({
    required DateTime startt,
    required DateTime endd,
  }) async {
    DateTime start = DateTime(startt.year, startt.month, startt.day);
    DateTime end = DateTime(endd.year, endd.month, endd.day);
    p(start.toIso8601String());
    p(end.toIso8601String());
    List<CookerProduct> data = [];
    try {
      Response<dynamic> res = await Dio().get(
        "${AuthService.localhost}/out/api/cook/getInOut?end=${end.millisecondsSinceEpoch}&start=${start.millisecondsSinceEpoch}",
        options: AuthService.option,
      );

      for (int i = 0; i < (res.data as List).length; i++) {
        if (res.data[i] != null) {
          data.add(CookerProduct.fromJson(res.data[i]));
        }
      }
      return data;
    } catch (e) {
      throw Exception(
          "CookerService / getSentProductFromWarehouse: " + e.toString());
    }
  }

  Future<List<CookerProduct>> getInOutDefault() async {
    List<CookerProduct> data = [];
    try {
      Response<dynamic> res = await Dio().get(
        "${AuthService.localhost}/out/api/cook/getInOut",
        options: AuthService.option,
      );

      for (int i = 0; i < (res.data as List).length; i++) {
        if (res.data[i] != null) {
          data.add(CookerProduct.fromJson(res.data[i]));
        }
      }
      return data;
    } catch (e) {
      throw Exception("CookerService / getInOutDefault: " + e.toString());
    }
  }

  Future<List<CookerInOutListProduct>> getAvailbleProductsInStorage() async {
    try {
      Response res = await Dio().get(
        //OMBOR
        "${AuthService.localhost}/out/api/cook/getProductBalancer",
        options: AuthService.option,
      );
      return (res.data as List)
          .map((e) => CookerInOutListProduct.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(
          "InOutListProductService / getAvailableProductsInStorage: " +
              e.toString());
    }
  }

  Future<List<CookerInOutListProduct>> getExistingProduct() async {
    try {
      Response res = await Dio().get(
        // ZAHIRADAGI
        "${AuthService.localhost}/out/api/cook/getExistingProduct",
        options: AuthService.option,
      );
      return (res.data as List)
          .map((e) => CookerInOutListProduct.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(
          "InOutListProductService / getAvailableProductsInStorage: " +
              e.toString());
    }
  }

  Future<MealInfo> getMealInfo(int mealAgeStandartId, int menuId) async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/meal/getMeal?mealAgeStandardId=$mealAgeStandartId&menuId=$menuId",
        options: AuthService.option,
      );
      MealInfo d = MealInfo.fromJson(res.data);
      return d;
    } catch (e) {
      throw Exception("CookerService / getMealInfo" + e.toString());
    }
  }

  postGarbage(WasteProduct data, String id) async {
    try {
      Response res = await Dio().post(
        "${AuthService.localhost}/out/api/storage/garbageAdd/$id",
        options: AuthService.option,
        data: data,
      );
      return res.statusCode == 200;
    } catch (e) {
      throw Exception("CookerService / getMealInfo" + e.toString());
    }
  }

  Future<List<CookerInOutListProduct>> getGarbage(
      DateTime start, DateTime end) async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/storage/garbageGet?end=${end.millisecondsSinceEpoch}&start=${start.millisecondsSinceEpoch}",
        options: AuthService.option,
      );
      return (res.data as List)
          .map((e) => CookerInOutListProduct.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception("CookerService / getGarbage: " + e.toString());
    }
  }

  Future<bool> deleteGarbage(int id) async {
    try {
      Response res = await Dio().delete(
        "${AuthService.localhost}/out/api/storage/garbageDelete/$id",
        options: AuthService.option,
      );
      return res.statusCode == 200;
    } catch (e) {
      throw Exception("CookerService / deleteGarbage: " + e.toString());
    }
  }
}
