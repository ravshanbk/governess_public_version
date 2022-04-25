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
  Options option = Options(headers: {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJyb2xlcyI6IlJPTEVfT1NIUEFaIiwic3ViIjoiYjJvc2hwYXoiLCJpYXQiOjE2NTA4NzEzNTIsImV4cCI6MTY1MTczNTM1Mn0.lANN2hSHjxD44i1qRDJ0yKCExoBU8MELUnuwgz0fFUM"
  });
  Future<ResModel> acceptProduct(ReceiveProductModel data,
      {required String id}) async {
    p(data.numberPack.toString());
    p(data.comment.toString());
    p(data.weightPack.toString());
    p(id);
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
      Response res = await Dio().put(
        "${AuthService.localhost}/out/api/cook/receive/$id",
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
      p(res.data.toString());
      return (res.data as List).map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception(
          "CookerService / getSentProductFromWarehouse: " + e.toString());
    }
  }

  Future<List<CookerProduct>> getAvailbleProductsInStorage() async {
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
      // Response res = await Dio().get(
      //   //OMBOR
      //   "${AuthService.localhost}/out/api/cook/getProductBalancer",
      //   options: option,
      // );
      // debugPrint("getAvailableProductsInStorage function ichi: " +
      //     res.data.toString());
      // return (res.data as List).map((e) => CookerProduct.fromJson(e)).toList();
      return hardData.map((e) => CookerProduct.fromJson(e)).toList();
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
      // Response res = await Dio().get(
      //   // ZAHIRADAGI
      //   "${AuthService.localhost}/out/api/cook/getExistingProduct",
      //   options: option,
      // );
      // p("Get Existing Product Cooker service: "+res.data.toString());
      // return (res.data as List).map((e) => CookerProduct.fromJson(e)).toList();
      return hardData.map((e) => CookerProduct.fromJson(e)).toList();
    } catch (e) {
      throw Exception(
          "InOutListProductService getAvailableProductsInStorage: " +
              e.toString());
    }
  }

  Future<MealInfo> getMealInfo(int mealAgeStandartId, int menuId) async {
    var hardData = {
      "id": 16,
      "name": "Pishloq va sariyog`li buterbrod",
      "weight": 55.00,
      "mealCategoryId": 2,
      "mealCategoryName": "Non yoki buterbrodlar",
      "productMeals": [
        {
          "id": 63,
          "weight": 1533.0,
          "withoutExit": 1533.0,
          "productId": 160,
          "name": "Non"
        },
        {
          "id": 61,
          "weight": 378.0,
          "withoutExit": 378.0,
          "productId": 174,
          "name": "Pishloq"
        },
        {
          "id": 62,
          "weight": 189.0,
          "withoutExit": 189.0,
          "productId": 192,
          "name": "Saryogʼ"
        }
      ],
      "ingredientDTO": {
        "id": null,
        "protein": 5.75,
        "kcal": 175.40,
        "oil": 7.85,
        "carbohydrates": 20.05
      },
      "attachment": {
        "id": 16,
        "bytes":
            "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"
      },
      "comment": " "
    };

    try {
      Response res = await Dio().get(
        "${AuthService.localhost}/out/api/meal/getMeal?mealAgeStandardId=$mealAgeStandartId&menuId=$menuId",
        options: option,
      );
      p("${AuthService.localhost}/out/api/meal/getMeal?mealAgeStandardId=$mealAgeStandartId&menuId=$menuId");
      p("MEAL INFO: " + res.data.toString());
      return MealInfo.fromJson(res.data);
      // return MealInfo.fromJson(hardData);
    } catch (e) {
      throw Exception("CookerService / getMealInfo" + e.toString());
    }
  }

  postGarbage(WasteProduct data, String id) async {
    try {
      Response res = await Dio().post(
        "${AuthService.localhost}/out/api/storage/garbageAdd/$id",
        options: option,
        data: data,
      );
      return true;
    } catch (e) {
      throw Exception("CookerService / getMealInfo" + e.toString());
    }
  }
}
///out/api/storage/garbageGet