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
  final List<Balancer> _hardDateBalancer = List.generate(
      15,
      (index) => Balancer(
            numberPack: 12.3,
            pack: 12.3,
            productId: 123,
            productName: "productName",
            weight: 12.3,
          ));
  List<CookerProduct> hardCookerProduct = List.generate(
      15,
      (index) => CookerProduct(
            companyName: "CompanyName",
            id: "id",
            kindergartenAddress: "kinderGartenAdress",
            kindergartenName: "kindergartenName",
            measurementType: "gramm",
            orderNumber: "orderNumber",
            pack: "123",
            productId: "123",
            productName: "productName",
            receiver: "receiver",
            sendNumberPack: "123",
            sendWeight: "4884",
            status: "status",
            successNumberPack: "45",
            successWeight: "successWeight",
            theSender: "theSender",
            timeOfShipment: "15764747646764",
            timeTaken: "15764747646764",
          ));
  Future<ResModel> acceptProduct(
      {required ReceiveProductModel data, required String id}) async {
    try {
      // Response res = await Dio().put(
      //   "${AuthService.localhost}/out/api/cook/receive/$id",
      //   options: Options(headers: {
      //     "Authorization": Boxes.getUser().values.first.token,
      //   }),
      //   data: data,
      // );
      // return ResModel.fromJson(res.data);
      return ResModel(
          object: {}, success: true, text: "Muvaffaqiyatli qabul qilindi");
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
      // Response<dynamic> res = await Dio().get(
      //   "${AuthService.localhost}/out/api/cook/getInOut?end=${end.millisecondsSinceEpoch}&start=${start.millisecondsSinceEpoch}",
      //   options: Options(headers: {
      //     "Authorization": Boxes.getUser().values.first.token,
      //   }),
      // );

      // for (int i = 0; i < (res.data as List).length; i++) {
      //   if (res.data[i] != null) {
      //     data.add(CookerProduct.fromJson(res.data[i]));
      //   }
      // }
      // return data;
      return hardCookerProduct;
    } catch (e) {
      throw Exception(
          "CookerService / getSentProductFromWarehouse: " + e.toString());
    }
  }

  Future<List<CookerProduct>> getInOutDefault() async {
    List<CookerProduct> data = [];
    try {
      // Response<dynamic> res = await Dio().get(
      //   "${AuthService.localhost}/out/api/cook/getInOut",
      //   options: Options(headers: {
      //     "Authorization": Boxes.getUser().values.first.token,
      //   }),
      // );

      // for (int i = 0; i < (res.data as List).length; i++) {
      //   if (res.data[i] != null) {
      //     data.add(CookerProduct.fromJson(res.data[i]));
      //   }
      // }
      // return data;
      return hardCookerProduct;
    } catch (e) {
      throw Exception("CookerService / getInOutDefault: " + e.toString());
    }
  }

  Future<List<Balancer>> getAvailbleProductsInStorage() async {
    try {
      // Response res = await Dio().get(
      //   "${AuthService.localhost}/out/api/cook/getProductBalancer",
      //   options: Options(headers: {
      //     "Authorization": Boxes.getUser().values.first.token,
      //   }),
      // );

      // return (res.data as List).map((e) => Balancer.fromJson(e)).toList();
      return _hardDateBalancer;
    } catch (e) {
      throw Exception(
          "InOutListProductService / getAvailableProductsInStorage: " +
              e.toString());
    }
  }

  Future<List<Balancer>> getExistingProduct() async {
    try {
      // Response res = await Dio().get(
      //   // ZAHIRADAGI
      //   "${AuthService.localhost}/out/api/cook/getExistingProduct",
      //   options: Options(headers: {
      //     "Authorization": Boxes.getUser().values.first.token,
      //   }),
      // );
      // return (res.data as List).map((e) => Balancer.fromJson(e)).toList();
      return _hardDateBalancer;
    } catch (e) {
      throw Exception(
          "InOutListProductService / getAvailableProductsInStorage: " +
              e.toString());
    }
  }

  Future<MealInfo> getMealInfo(int mealAgeStandartId, int menuId) async {
    Map<String, dynamic> hardData = {
      "id": 60,
      "name": "Povidloli uvalanadigan pirog",
      "weight": 1.200000,
      "mealCategoryId": 11,
      "mealCategoryName": "Pishiriq va bulochka",
      "productMeals": [
        {
          "id": 336,
          "weight": 0.22,
          "withoutExit": 0.22,
          "productId": 91,
          "name": "Povidlo"
        },
        {
          "id": 338,
          "weight": 0.2,
          "withoutExit": 0.2,
          "productId": 58,
          "name": "Shakar"
        },
        {
          "id": 340,
          "weight": 0.58,
          "withoutExit": 0.58,
          "productId": 19,
          "name": "Un (1-sort)"
        },
        {
          "id": 339,
          "weight": 0.09,
          "withoutExit": 0.09,
          "productId": 26,
          "name": "Tuxum"
        },
        {
          "id": 335,
          "weight": 0.01,
          "withoutExit": 0.01,
          "productId": 78,
          "name": "Tuz"
        },
        {
          "id": 337,
          "weight": 0.13,
          "withoutExit": 0.13,
          "productId": 57,
          "name": "Saryogʼ"
        },
        {
          "id": 342,
          "weight": 0.0,
          "withoutExit": 0.0,
          "productId": 22,
          "name": "Xamirturush"
        },
        {
          "id": 341,
          "weight": 0.0,
          "withoutExit": 0.0,
          "productId": 21,
          "name": "Vanil"
        }
      ],
      "ingredientDTO": {
        "id": null,
        "protein": 3.767000,
        "kcal": 220.716000,
        "oil": 6.287000,
        "carbohydrates": 37.300000
      },
      "attachmentId": 334,
      "comment": " ",
      "perDayDTO": {
        "id": null,
        "createDate": 1653717085521,
        "date": 1654023600000,
        "updateDate": 1653723976042,
        "createdBy": null,
        "updateBy": null,
        "status": "QABUL QILINDI",
        "attachmentId": 372,
        "numberOfChildrenDTOList": [
          {
            "id": 1249,
            "number": 10,
            "createDate": 1653717085523,
            "updateDate": 1653717085523,
            "ageGroupId": 1,
            "ageGroupName": "3-4"
          },
          {
            "id": 1250,
            "number": 10,
            "createDate": 1653717085524,
            "updateDate": 1653717085524,
            "ageGroupId": 2,
            "ageGroupName": "4-7"
          },
          {
            "id": 1251,
            "number": 10,
            "createDate": 1653717085525,
            "updateDate": 1653717085525,
            "ageGroupId": 3,
            "ageGroupName": "Qisqa muddatli"
          },
          {
            "id": 1252,
            "number": 10,
            "createDate": 1653717085526,
            "updateDate": 1653717085526,
            "ageGroupId": 4,
            "ageGroupName": "Xodim"
          }
        ],
        "kindergartenId": 3,
        "kindergartenName": "3-DMTT"
      }
    };
    try {
      // Response res = await Dio().get(
      //   "${AuthService.localhost}/out/api/meal/getMeal?mealAgeStandardId=$mealAgeStandartId&menuId=$menuId",
      //   options: Options(headers: {
      //     "Authorization": Boxes.getUser().values.first.token,
      //   }),
      // );

      // return MealInfo.fromJson(res.data);
      return MealInfo.fromJson(hardData);
    } catch (e) {
      throw Exception("CookerService / getMealInfo" + e.toString());
    }
  }

  Future<ResModel> postGarbage(
    WasteProduct data,
  ) async {
    try {
      // Response res = await Dio().post(
      //   "${AuthService.localhost}/out/api/cook/garbageAdd",
      //   options: Options(headers: {
      //     "Authorization": Boxes.getUser().values.first.token,
      //   }),
      //   data: data,
      // );
      // return ResModel.fromJson(res.data);
      return ResModel(
          object: {}, success: true, text: "Muvaffaqiyatli chiqarildi");
    } catch (e) {
      return ResModel(object: {}, success: false, text: "Nimadir hato bo'ldi");
    }
  }

  Future<List<Garbage>> getGarbage(
      {required DateTime start,
      required DateTime end,
      required bool isDefault}) async {
    List<Garbage> hardDataGarbage = List.generate(
        15,
        (index) => Garbage(
              acceptByName: "acceptByName",
              acceptDate: 12344566788909,
              comment: "comment",
              createDate: 12345667899009,
              createdByName: "createdByName",
              id: 123,
              kindergartenName: "kindergartenName",
              productName: "productName",
              status: "status",
              updateDate: 1234567890098,
              weight: 123.0,
            ));
    try {
      // Response res = await Dio().get(
      //   isDefault
      //       ? "${AuthService.localhost}/out/api/cook/garbageGet"
      //       : "${AuthService.localhost}/out/api/cook/garbageGet?end=${end.millisecondsSinceEpoch}&start=${start.millisecondsSinceEpoch}",
      //   options: Options(headers: {
      //     "Authorization": Boxes.getUser().values.first.token,
      //   }),
      // );

      // return (res.data as List).map((e) => Garbage.fromJson(e)).toList();
      return hardDataGarbage;
    } catch (e) {
      throw Exception("CookerService / getGarbage: " + e.toString());
    }
  }

  Future<bool> deleteGarbage(int id) async {
    try {
      // Response res = await Dio().delete(
      //   "${AuthService.localhost}/out/api/storage/garbageDelete/$id",
      //   options: Options(headers: {
      //     "Authorization": Boxes.getUser().values.first.token,
      //   }),
      // );
      return true;
    } catch (e) {
      throw Exception("CookerService / deleteGarbage: " + e.toString());
    }
  }
}
