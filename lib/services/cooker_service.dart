import 'package:dio/dio.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/cooker/garbage_model.dart';
import 'package:governess/models/cooker/meal_info_model.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/cooker/receive_product_model.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';
import 'package:governess/models/cooker/waste_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/services/auth_service.dart';

class CookerService {
  Future<ResModel> acceptProduct(
      {required ReceiveProductModel data, required String id}) async {
    try {
      Response res = await Dio().put(
        "${AuthService.localhost}/out/api/cook/receive/$id",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
        data: data,
      );
      return ResModel.fromJson(res.data);
    } on DioError catch (e) {
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
    List<CookerProduct> data = [];
    try {
      Response<dynamic> res = await Dio().get(
        "${AuthService.localhost}/out/api/cook/getInOut?end=${end.millisecondsSinceEpoch}&start=${start.millisecondsSinceEpoch}",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );

      for (int i = 0; i < (res.data as List).length; i++) {
        if (res.data[i] != null) {
          data.add(CookerProduct.fromJson(res.data[i]));
        }
      }
      return data;
      // return hardDate;
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
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );

      for (int i = 0; i < (res.data as List).length; i++) {
        if (res.data[i] != null) {
          data.add(CookerProduct.fromJson(res.data[i]));
        }
      }
      return data;
      // return hardDate;
    } catch (e) {
      throw Exception("CookerService / getInOutDefault: " + e.toString());
    }
  }

  Future<List<Balancer>> getAvailbleProductsInStorage() async {
    print(Boxes.getUser().values.first.token);
    try {
      Response res = await Dio().get(
        //OMBOR
        "${AuthService.localhost}/out/api/cook/getProductBalancer",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );

      return (res.data as List).map((e) => Balancer.fromJson(e)).toList();
    } catch (e) {
      throw Exception(
          "InOutListProductService / getAvailableProductsInStorage: " +
              e.toString());
    }
  }

  Future<List<Balancer>> getExistingProduct() async {
    // List<CookerInOutListProduct> _hardDate = List.generate(
    //   12,
    //   (index) => CookerInOutListProduct(
    //     inOutList: [
    //       InOutList(
    //         enterDate: 1651920125853,
    //         id: "5ece38bf-526a-4c7a-ac17-6586e3612819",
    //         measurementType: "gramm",
    //         numberPack: 1,
    //         pack: 1,
    //         price: 1,
    //         status: "",
    //         weightPack: 1,
    //       )
    //     ],
    //     productId: 1,
    //     productName: "name $index",
    //     weight: 212.0,
    //   ),
    // );
    try {
      Response res = await Dio().get(
        // ZAHIRADAGI
        "${AuthService.localhost}/out/api/cook/getExistingProduct",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );
      return (res.data as List).map((e) => Balancer.fromJson(e)).toList();
      // return _hardDate;
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
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );
      MealInfo? d;
      try {
        d = MealInfo.fromJson(res.data);
      } catch (e) {
        throw Exception(e);
      }

      return d;
    } catch (e) {
      throw Exception("CookerService / getMealInfo" + e.toString());
    }
  }

 Future<ResModel> postGarbage(
    WasteProduct data,
  ) async {
    try {
      Response res = await Dio().post(
        "${AuthService.localhost}/out/api/cook/garbageAdd",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
        data: data,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      return ResModel(object: {}, success: false, text: "Nimadir hato bo'ldi");
    }
  }

  Future<List<Garbage>> getGarbage(
      {required DateTime start,
      required DateTime end,
      required bool isDefault}) async {
    print(DTFM.maker(start.millisecondsSinceEpoch).toString());
    print(DTFM.maker(end.millisecondsSinceEpoch).toString());
    print(
      "${AuthService.localhost}/out/api/storage/garbageGet?end=${end.millisecondsSinceEpoch}&start=${start.millisecondsSinceEpoch}",
    );
    print(Boxes.getUser().values.first.token);
    try {
      Response res = await Dio().get(
        isDefault
            ? "${AuthService.localhost}/out/api/cook/garbageGet"
            : "${AuthService.localhost}/out/api/cook/garbageGet?end=${end.millisecondsSinceEpoch}&start=${start.millisecondsSinceEpoch}",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );
      print(res.data);
      return (res.data as List).map((e) => Garbage.fromJson(e)).toList();
    } catch (e) {
      throw Exception("CookerService / getGarbage: " + e.toString());
    }
  }

  Future<bool> deleteGarbage(int id) async {
    try {
      Response res = await Dio().delete(
        "${AuthService.localhost}/out/api/storage/garbageDelete/$id",
        options: Options(headers: {
          "Authorization": Boxes.getUser().values.first.token,
        }),
      );
      return res.statusCode == 200;
    } catch (e) {
      throw Exception("CookerService / deleteGarbage: " + e.toString());
    }
  }
}
