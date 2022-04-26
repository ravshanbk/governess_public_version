import 'package:dio/dio.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/cooker/meal_info_model.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/cooker/receive_product_model.dart';
import 'package:governess/models/cooker/waste_product_model.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/services/auth_service.dart';

class CookerService {
  Future<ResModel> acceptProduct(ReceiveProductModel data,
      {required String id}) async {
    try {
      Response res = await Dio().put(
        "${AuthService.localhost}/out/api/cook/receive/$id",
        options: AuthService.option,
        data: data,
      );
      return ResModel.fromJson(res.data);
    } catch (e) {
      throw Exception("Chef Service acceptProduct: " + e.toString());
    }
  }

  Future<NumberOfChildren> getChildrenNumberByData(DateTime date) async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/perDay",
        options: AuthService.option,
      );
      return NumberOfChildren.fromJson(res.data);
    } catch (e) {
      throw Exception("CookerService acceptProduct:" + e.toString());
    }
  }

  Future<List<Product>> getSentProductFromWarehouse() async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/cook/getInOut",
        options: AuthService.option,
      );
      return (res.data as List).map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception(
          "CookerService / getSentProductFromWarehouse: " + e.toString());
    }
  }

  Future<List<CookerProduct>> getAvailbleProductsInStorage() async {
    try {
      Response res = await Dio().get(
        //OMBOR
        "${AuthService.localhost}/out/api/cook/getProductBalancer",
        options: AuthService.option,
      );
      p(res.data.toString());
      return (res.data as List).map((e) => CookerProduct.fromJson(e)).toList();
    } catch (e) {
      throw Exception(
          "InOutListProductService getAvailableProductsInStorage: " +
              e.toString());
    }
  }

  Future<List<CookerProduct>> getExistingProduct() async {
    var hardData = [
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870651622,
            "price": 70000.00,
            "pack": 1.00,
            "numberPack": 39000.00,
            "weightPack": 39000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Mol go`shti",
        "productId": null,
        "weight": 39000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650872515659,
            "price": 3000.00,
            "pack": 1.00,
            "numberPack": 500.00,
            "weightPack": 500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Sabzi",
        "productId": null,
        "weight": 500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870664274,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 1350.00,
            "weightPack": 1350.00,
            "measurementType": "gramm",
            "status": null
          },
          {
            "id": null,
            "enterDate": 1650870671361,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 1350.00,
            "weightPack": 1350.00,
            "measurementType": "gramm",
            "status": null
          },
          {
            "id": null,
            "enterDate": 1650870684444,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 650.00,
            "weightPack": 650.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Tomat pastasi",
        "productId": null,
        "weight": 3350.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870692857,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 4000.00,
            "weightPack": 4000.00,
            "measurementType": "gramm",
            "status": null
          },
          {
            "id": null,
            "enterDate": 1650872437882,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 1000.00,
            "weightPack": 1000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Tuz",
        "productId": null,
        "weight": 5000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870703257,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 17000.00,
            "weightPack": 17000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Baliq (boshsiz, tozalangan)",
        "productId": null,
        "weight": 17000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870713804,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 33500.00,
            "weightPack": 33500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Banan",
        "productId": null,
        "weight": 33500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870728222,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 6500.00,
            "weightPack": 6500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Bodring",
        "productId": null,
        "weight": 6500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870741303,
            "price": 1500.00,
            "pack": 1.00,
            "numberPack": 3000.00,
            "weightPack": 3000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Gul karam",
        "productId": null,
        "weight": 3000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870752686,
            "price": 120.00,
            "pack": 1.00,
            "numberPack": 1000.00,
            "weightPack": 1000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Kakao-poroshok",
        "productId": null,
        "weight": 1000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870758230,
            "price": 10000.00,
            "pack": 1.00,
            "numberPack": 4000.00,
            "weightPack": 4000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Karam",
        "productId": null,
        "weight": 4000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870776566,
            "price": 5000.00,
            "pack": 1.00,
            "numberPack": 44500.00,
            "weightPack": 44500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Karam xitoy (basay)",
        "productId": null,
        "weight": 44500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650870917601,
            "price": 5000.00,
            "pack": 1.00,
            "numberPack": 77000.00,
            "weightPack": 77000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Kartoshka",
        "productId": null,
        "weight": 77000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871149001,
            "price": 35000.00,
            "pack": 1.00,
            "numberPack": 500.00,
            "weightPack": 500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Kashnich doni",
        "productId": null,
        "weight": 500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871155633,
            "price": 200.00,
            "pack": 1.00,
            "numberPack": 64000.00,
            "weightPack": 64000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Kefir",
        "productId": null,
        "weight": 64000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871170585,
            "price": 6000.00,
            "pack": 1.00,
            "numberPack": 3500.00,
            "weightPack": 3500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Koʼkat",
        "productId": null,
        "weight": 3500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871176056,
            "price": 55000.00,
            "pack": 1.00,
            "numberPack": 2000.00,
            "weightPack": 2000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Kraxmal kartoshka",
        "productId": null,
        "weight": 2000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871186085,
            "price": 1500.00,
            "pack": 1.00,
            "numberPack": 14500.00,
            "weightPack": 14500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Lavlagi",
        "productId": null,
        "weight": 14500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871290646,
            "price": 25000.00,
            "pack": 1.00,
            "numberPack": 3000.00,
            "weightPack": 3000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Limon",
        "productId": null,
        "weight": 3000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871297689,
            "price": 24000.00,
            "pack": 1.00,
            "numberPack": 10500.00,
            "weightPack": 10500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Manka",
        "productId": null,
        "weight": 10500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871306706,
            "price": 1200.00,
            "pack": 1.00,
            "numberPack": 5000.00,
            "weightPack": 5000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Mayiz",
        "productId": null,
        "weight": 5000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871318052,
            "price": 12000.00,
            "pack": 1.00,
            "numberPack": 4500.00,
            "weightPack": 4500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Murabbo (bexi)",
        "productId": null,
        "weight": 4500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871333702,
            "price": 120.00,
            "pack": 1.00,
            "numberPack": 89000.00,
            "weightPack": 89000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Non",
        "productId": null,
        "weight": 89000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871342230,
            "price": 14000.00,
            "pack": 1.00,
            "numberPack": 2000.00,
            "weightPack": 2000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Noʼxat (yarimta, gorox)",
        "productId": null,
        "weight": 2000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871347147,
            "price": 19000.00,
            "pack": 1.00,
            "numberPack": 6500.00,
            "weightPack": 6500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "O`simlik moyi",
        "productId": null,
        "weight": 6500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871352535,
            "price": 5000.00,
            "pack": 1.00,
            "numberPack": 54000.00,
            "weightPack": 54000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Olma",
        "productId": null,
        "weight": 54000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871359705,
            "price": 12000.00,
            "pack": 1.00,
            "numberPack": 2500.00,
            "weightPack": 2500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Oq joʼxori",
        "productId": null,
        "weight": 2500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871395161,
            "price": 1500.00,
            "pack": 1.00,
            "numberPack": 3000.00,
            "weightPack": 3000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Ovsyanka",
        "productId": null,
        "weight": 3000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871577224,
            "price": 35000.00,
            "pack": 1.00,
            "numberPack": 6500.00,
            "weightPack": 6500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Pishloq",
        "productId": null,
        "weight": 6500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871585938,
            "price": 12000.00,
            "pack": 1.00,
            "numberPack": 4000.00,
            "weightPack": 4000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Pomidor",
        "productId": null,
        "weight": 4000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871592065,
            "price": 18000.00,
            "pack": 1.00,
            "numberPack": 2000.00,
            "weightPack": 2000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Povidlo",
        "productId": null,
        "weight": 2000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871667601,
            "price": 14000.00,
            "pack": 1.00,
            "numberPack": 2500.00,
            "weightPack": 2500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Psheno yormasi",
        "productId": null,
        "weight": 2500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871597604,
            "price": 6000.00,
            "pack": 1.00,
            "numberPack": 2500.00,
            "weightPack": 2500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Qizil karam",
        "productId": null,
        "weight": 2500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871603539,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 3000.00,
            "weightPack": 3000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Quruq meva",
        "productId": null,
        "weight": 3000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871608462,
            "price": 3500.00,
            "pack": 1.00,
            "numberPack": 500.00,
            "weightPack": 500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Sarimsoq piyoz",
        "productId": null,
        "weight": 500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871615822,
            "price": 12000.00,
            "pack": 1.00,
            "numberPack": 16000.00,
            "weightPack": 16000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Saryogʼ",
        "productId": null,
        "weight": 16000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871623433,
            "price": 1200.00,
            "pack": 1.00,
            "numberPack": 20000.00,
            "weightPack": 20000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Shakar",
        "productId": null,
        "weight": 20000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871638119,
            "price": 2300.00,
            "pack": 1.00,
            "numberPack": 2500.00,
            "weightPack": 2500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Shipovnik (quruq)",
        "productId": null,
        "weight": 2500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871647744,
            "price": 1200.00,
            "pack": 1.00,
            "numberPack": 1000.00,
            "weightPack": 1000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Suxarik panirovochniy",
        "productId": null,
        "weight": 1000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871658289,
            "price": 1000.00,
            "pack": 1.00,
            "numberPack": 11500.00,
            "weightPack": 11500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Tovuq filesi",
        "productId": null,
        "weight": 11500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871693712,
            "price": 1200.00,
            "pack": 60.00,
            "numberPack": 219.00,
            "weightPack": 13140.00,
            "measurementType": "dona",
            "status": null
          }
        ],
        "productName": "Tuxum",
        "productId": null,
        "weight": 13140.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871744341,
            "price": 125.00,
            "pack": 1.00,
            "numberPack": 17500.00,
            "weightPack": 17500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Tvorog",
        "productId": null,
        "weight": 17500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871765980,
            "price": 1300.00,
            "pack": 1.00,
            "numberPack": 11000.00,
            "weightPack": 11000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Un (1-sort)",
        "productId": null,
        "weight": 11000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871779381,
            "price": 5000.00,
            "pack": 1.00,
            "numberPack": 5500.00,
            "weightPack": 5500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Un (oliy sort)",
        "productId": null,
        "weight": 5500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871790749,
            "price": 124.00,
            "pack": 1.00,
            "numberPack": 500.00,
            "weightPack": 500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Vanil",
        "productId": null,
        "weight": 500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871800727,
            "price": 232.00,
            "pack": 1.00,
            "numberPack": 500.00,
            "weightPack": 500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Xamirturush",
        "productId": null,
        "weight": 500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871809625,
            "price": 110.00,
            "pack": 1.00,
            "numberPack": 1000.00,
            "weightPack": 1000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Yeryongʼoq",
        "productId": null,
        "weight": 1000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871816656,
            "price": 500.00,
            "pack": 1.00,
            "numberPack": 500.00,
            "weightPack": 500.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Zira",
        "productId": null,
        "weight": 500.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871822878,
            "price": 530.00,
            "pack": 1.00,
            "numberPack": 6000.00,
            "weightPack": 6000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Mandarin",
        "productId": null,
        "weight": 6000.00
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1650871833427,
            "price": 4000.00,
            "pack": 1.00,
            "numberPack": 2000.00,
            "weightPack": 2000.00,
            "measurementType": "gramm",
            "status": null
          }
        ],
        "productName": "Rediska",
        "productId": null,
        "weight": 2000.00
      }
    ];

    try {
      Response res = await Dio().get(
        // ZAHIRADAGI
        "${AuthService.localhost}/out/api/cook/getExistingProduct",
        options: AuthService.option,
      );
      p("Get Existing Product Cooker service: " + res.data.toString());
      return (res.data as List).map((e) => CookerProduct.fromJson(e)).toList();
    } catch (e) {
      throw Exception(
          "InOutListProductService getAvailableProductsInStorage: " +
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
      p(d.toString());
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

  Future<List<CookerProduct>> getGarbage(DateTime start, DateTime end) async {
    try {
      Response res = await Dio().get(
        "http://185.217.131.117:7788/out/api/storage/garbageGet?end=1650430517333&start=1650948917333",
        options: AuthService.option,
      );
      return (res.data as List).map((e) => CookerProduct.fromJson(e)).toList();
    } catch (e) {
      throw Exception("CookerService / getGarbage: " + e.toString());
    }
  }

  deleteGarbage() async {
    try {
      Response res = await Dio().delete(
        "${AuthService.localhost}/out/api/storage/garbageDelete/{id}",
        options: AuthService.option,
      );
      return res.statusCode == 200;
    } catch (e) {
      throw Exception("CookerService / deleteGarbage: " + e.toString());
    }
  }
}
