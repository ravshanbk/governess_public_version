import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:governess/models/in_out_list_product_model.dart';

class InOutListProductService {
  Future<List<InoutListProduct>> getAvailableProductsInStorage() async {
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
      // var res = await Dio()
      //     .get("http://192.168.1.38:7788/out/api/cook/getProductBalancer");
      // debugPrint("getAvailableProductsInStorage function ichi: " +
      //     res.data.toString());
      // return (res.data as List)
      //     .map((e) => InoutListProduct.fromJson(e))
      //     .toList();
      return hardData.map((e) => InoutListProduct.fromJson(e)).toList();
    } catch (e) {
      throw Exception(
          "InOutListProductService getAvailableProductsInStorage: " +
              e.toString());
    }
  }
}
