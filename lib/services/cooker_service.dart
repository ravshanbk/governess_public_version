import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/models/cooker/receive_product_model.dart';
import 'package:governess/models/in_out_list_product_model.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/other/post_res_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/services/auth_service.dart';

class CookerService {
  Options option = Options(headers: {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJyb2xlcyI6IlJPTEVfT1NIUEFaIiwic3ViIjoiYjJvc2hwYXoiLCJpYXQiOjE2NTA1NDYzODQsImV4cCI6MTY1MTQxMDM4NH0.LDKQjbFj29mssqXo89j1YaoLn4mgXgONT9RYT6lpMEQ"
  });
  Future<ResModel> acceptProduct(ReceiveProductModel data) async {
    List<Map<String, dynamic>> hardData = [
      {
        "id": 4,
        "createDate": 1648726870566,
        "updateDate": 1648726870566,
        "sendDate": 1648726870566,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 0.00,
        "numberPack": 0.00,
        "weightPack": 4966.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Starlink",
        "companyId": 3,
        "productId": 97,
        "productName": "Sut",
        "comment": null
      },
      {
        "id": 5,
        "createDate": 1648726870576,
        "updateDate": 1648726870576,
        "sendDate": 1648726870576,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 300.00,
        "numberPack": 13.00,
        "weightPack": 3900.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Yengi Yechim",
        "companyId": 3,
        "productId": 38,
        "productName": "Kartoshka",
        "comment": null
      },
      {
        "id": 6,
        "createDate": 1648726870584,
        "updateDate": 1648726870584,
        "sendDate": 1651965687584,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 0.00,
        "numberPack": 0.00,
        "weightPack": 1306.40,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Starlin",
        "companyId": 3,
        "productId": 95,
        "productName": "Smetana",
        "comment": null
      },
      {
        "id": 7,
        "createDate": 1648726870592,
        "updateDate": 1648726870592,
        "sendDate": 1649373687640,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 1000.00,
        "numberPack": 15.00,
        "weightPack": 15000.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Starli",
        "companyId": 3,
        "productId": 18,
        "productName": "Baliq (boshsiz, tozalangan)",
        "comment": null
      },
      {
        "id": 8,
        "createDate": 1648726870600,
        "updateDate": 1648726870600,
        "sendDate": 1651965687584,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 0.00,
        "numberPack": 0.00,
        "weightPack": 3438.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Starl",
        "companyId": 3,
        "productId": 58,
        "productName": "Non",
        "comment": null
      },
      {
        "id": 9,
        "createDate": 1648726870611,
        "updateDate": 1648726870611,
        "sendDate": 1649373687638,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 50.00,
        "numberPack": 559.00,
        "weightPack": 27950.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Star",
        "companyId": 3,
        "productId": 11,
        "productName": "Mol go`shti",
        "comment": null
      },
      {
        "id": 10,
        "createDate": 1648726870623,
        "updateDate": 1648726870623,
        "sendDate": 1651965687584,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 0.00,
        "numberPack": 0.00,
        "weightPack": 1498.70,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Sta",
        "companyId": 3,
        "productId": 103,
        "productName": "Tuzlangan bodring",
        "comment": null
      },
      {
        "id": 11,
        "createDate": 1648726870632,
        "updateDate": 1648726870632,
        "sendDate": 1648726870632,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 500.00,
        "numberPack": 11.00,
        "weightPack": 5500.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "St",
        "companyId": 3,
        "productId": 45,
        "productName": "Lavlagi",
        "comment": null
      },
      {
        "id": 12,
        "createDate": 1648726870642,
        "updateDate": 1648726870642,
        "sendDate": 1651965687584,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 190.00,
        "numberPack": 11.00,
        "weightPack": 2090.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Starlink",
        "companyId": 3,
        "productId": 37,
        "productName": "Karam xitoy (basay)",
        "comment": null
      },
      {
        "id": 13,
        "createDate": 1648726870652,
        "updateDate": 1648726870652,
        "sendDate": 1648726870652,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 900.00,
        "numberPack": 5.00,
        "weightPack": 4500.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "S",
        "companyId": 3,
        "productId": 35,
        "productName": "Karam",
        "comment": null
      },
      {
        "id": 15,
        "createDate": 1648726870673,
        "updateDate": 1648726870673,
        "sendDate": 1648726870672,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 400.00,
        "numberPack": 2.00,
        "weightPack": 800.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "tarlink",
        "companyId": 3,
        "productId": 15,
        "productName": "Tomat pastasi",
        "comment": null
      },
      {
        "id": 16,
        "createDate": 1648726870684,
        "updateDate": 1648726870684,
        "sendDate": 1648726870683,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 2.00,
        "numberPack": 2046.00,
        "weightPack": 4092.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "arlink",
        "companyId": 3,
        "productId": 14,
        "productName": "Piyoz",
        "comment": null
      },
      {
        "id": 18,
        "createDate": 1648726870718,
        "updateDate": 1648726870718,
        "sendDate": 1648726870718,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 70.00,
        "numberPack": 127.00,
        "weightPack": 8890.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "rlink",
        "companyId": 3,
        "productId": 13,
        "productName": "Guruch",
        "comment": null
      },
      {
        "id": 19,
        "createDate": 1648726870739,
        "updateDate": 1648726870739,
        "sendDate": 1648726870738,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 0.00,
        "numberPack": 0.00,
        "weightPack": 399.50,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "link",
        "companyId": 3,
        "productId": 92,
        "productName": "Shakar",
        "comment": null
      },
      {
        "id": 20,
        "createDate": 1648726870758,
        "updateDate": 1648726870758,
        "sendDate": 1648726870758,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 0.00,
        "numberPack": 0.00,
        "weightPack": 1859.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "ink",
        "companyId": 3,
        "productId": 90,
        "productName": "Saryogʼ",
        "comment": null
      },
      {
        "id": 21,
        "createDate": 1648726870774,
        "updateDate": 1648726870774,
        "sendDate": 1648726870774,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 0.00,
        "numberPack": 0.00,
        "weightPack": 2568.80,
        "status": "YANGI",
        "measurementType": "dona",
        "companyName": "nk",
        "companyId": 3,
        "productId": 102,
        "productName": "Tuxum",
        "comment": null
      },
      {
        "id": 22,
        "createDate": 1648726870792,
        "updateDate": 1648727080108,
        "sendDate": 1648726870791,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 200.00,
        "numberPack": 9.00,
        "weightPack": 1800.00,
        "status": "QISMAN TUGALLANDI",
        "measurementType": "gramm",
        "companyName": "k",
        "companyId": 3,
        "productId": 21,
        "productName": "Bexi",
        "comment": null
      },
      {
        "id": 14,
        "createDate": 1648726870662,
        "updateDate": 1648727004778,
        "sendDate": 1648726870662,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 100.00,
        "numberPack": 4.00,
        "weightPack": 400.00,
        "status": "QISMAN TUGALLANDI",
        "measurementType": "gramm",
        "companyName": "Starlink",
        "companyId": 3,
        "productId": 12,
        "productName": "Sabzi",
        "comment": null
      },
      {
        "id": 17,
        "createDate": 1648726870699,
        "updateDate": 1648727063774,
        "sendDate": 1648726870699,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 0.00,
        "numberPack": 100.00,
        "weightPack": 3039.70,
        "status": "QISMAN TUGALLANDI",
        "measurementType": "gramm",
        "companyName": "Starflink",
        "companyId": 3,
        "productId": 61,
        "productName": "Noʼxat konservasi",
        "comment": null
      },
      {
        "id": 3,
        "createDate": 1648726870559,
        "updateDate": 1649141483055,
        "sendDate": 1648726870558,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 5.00,
        "numberPack": 70.00,
        "weightPack": 350.00,
        "status": "QISMAN TUGALLANDI",
        "measurementType": "gramm",
        "companyName": "Starlidnk",
        "companyId": 3,
        "productId": 16,
        "productName": "Tuz",
        "comment": null
      },
      {
        "id": 2,
        "createDate": 1648726870551,
        "updateDate": 1649141501947,
        "sendDate": 1648726870550,
        "orderNumber": "TEST ZAYAFKA",
        "price": null,
        "pack": 0.00,
        "numberPack": 0.00,
        "weightPack": 331.80,
        "status": "QISMAN TUGALLANDI",
        "measurementType": "gramm",
        "companyName": "Staralink",
        "companyId": 3,
        "productId": 106,
        "productName": "Un (1-sort)",
        "comment": null
      },
      {
        "id": 80,
        "createDate": 1649052421030,
        "updateDate": 1649052421030,
        "sendDate": 1649052420969,
        "orderNumber": null,
        "price": null,
        "pack": 5.00,
        "numberPack": 15.00,
        "weightPack": 75.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Sstarlink",
        "companyId": 3,
        "productId": 22,
        "productName": "Bodring",
        "comment": null
      },
      {
        "id": 81,
        "createDate": 1649052531513,
        "updateDate": 1649052531513,
        "sendDate": 1649052531513,
        "orderNumber": null,
        "price": null,
        "pack": 3.00,
        "numberPack": 45.00,
        "weightPack": 135.00,
        "status": "YANGI",
        "measurementType": "gramm",
        "companyName": "Staarlink",
        "companyId": 3,
        "productId": 24,
        "productName": "Bulgʼor qalampiri (svetofor)",
        "comment": null
      }
    ];

    try {
      Response res = await Dio().post(
        "${AuthService.localhost}/out/api/cook/receive/1",
        options: option,
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
        options: option,
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
        options: option,
      );
      return (res.data as List).map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception(
          "CookerService / getSentProductFromWarehouse: " + e.toString());
    }
  }

  Future<List<InoutListProduct>> getAvailbleProductsInStorage() async {
    var hardData = [
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573808070,
            "price": 1,
            "pack": 500,
            "numberPack": 770,
            "weightPack": 385000,
            "measurementType": "gramm"
          }
        ],
        "productName": "Mol go`shti",
        "weight": 385000
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573803410,
            "price": 12,
            "pack": 500,
            "numberPack": 134,
            "weightPack": 67000,
            "measurementType": "gramm"
          }
        ],
        "productName": "Sabzi",
        "weight": 67000
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573798599,
            "price": 17,
            "pack": 1000,
            "numberPack": 57,
            "weightPack": 57000,
            "measurementType": "gramm"
          }
        ],
        "productName": "Piyoz",
        "weight": 57000
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573793833,
            "price": 31,
            "pack": 500,
            "numberPack": 11,
            "weightPack": 5500,
            "measurementType": "gramm"
          }
        ],
        "productName": "Tomat pastasi",
        "weight": 5500
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573788088,
            "price": 47,
            "pack": 1000,
            "numberPack": 16,
            "weightPack": 16000,
            "measurementType": "gramm"
          }
        ],
        "productName": "Tuz",
        "weight": 16000
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573781921,
            "price": 12,
            "pack": 500,
            "numberPack": 780,
            "weightPack": 390000,
            "measurementType": "gramm"
          }
        ],
        "productName": "Baliq (boshsiz, tozalangan)",
        "weight": 390000
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573776997,
            "price": 15,
            "pack": 400,
            "numberPack": 231,
            "weightPack": 92400,
            "measurementType": "gramm"
          }
        ],
        "productName": "Non",
        "weight": 92400
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573771997,
            "price": 12,
            "pack": 400,
            "numberPack": 142,
            "weightPack": 56800,
            "measurementType": "gramm"
          }
        ],
        "productName": "Saryogʼ",
        "weight": 56800
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573766635,
            "price": 14,
            "pack": 1000,
            "numberPack": 134,
            "weightPack": 134000,
            "measurementType": "gramm"
          }
        ],
        "productName": "Sut",
        "weight": 134000
      },
      {
        "inOutList": [
          {
            "id": null,
            "enterDate": 1649573761335,
            "price": 14,
            "pack": 1,
            "numberPack": 5130,
            "weightPack": 5130,
            "measurementType": "gramm"
          }
        ],
        "productName": "Un (1-sort)",
        "weight": 5130
      }
    ];
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/cook/getProductBalancer",
        options: option,
      );
      debugPrint("getAvailableProductsInStorage function ichi: " +
          res.data.toString());
      return (res.data as List)
          .map((e) => InoutListProduct.fromJson(e))
          .toList();
      // return hardData.map((e) => InoutListProduct.fromJson(e)).toList();
    } catch (e) {
      throw Exception(
          "InOutListProductService getAvailableProductsInStorage: " +
              e.toString());
    }
  }

  Future<List<InoutListProduct>> getExistingProduct() async {
    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/cook/getExistingProduct",
        options: option,
      );
      return (res.data as List)
          .map((e) => InoutListProduct.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(
          "InOutListProductService getAvailableProductsInStorage: " +
              e.toString());
    }
  }
}
