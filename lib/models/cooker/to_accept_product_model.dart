// To parse this JSON data, do
//
//     final cookerProduct = cookerProductFromJson(jsonString);

import 'dart:convert';

List<CookerProduct> cookerProductFromJson(String str) =>
    List<CookerProduct>.from(
        json.decode(str).map((x) => CookerProduct.fromJson(x)));

String cookerProductToJson(List<CookerProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CookerProduct {
  CookerProduct({
    this.id,
    this.productName,
    this.productId,
    this.companyName,
    this.orderNumber,
    this.kindergartenName,
    this.kindergartenAddress,
    this.sendWeight,
    this.successWeight,
    this.sendNumberPack,
    this.successNumberPack,
    this.timeOfShipment,
    this.timeTaken,
    this.theSender,
    this.receiver,
    this.status,
    this.pack,
    this.measurementType,
  });

  String? id;
  String? productName;
  String? productId;
  String? companyName;
  String? orderNumber;
  String? kindergartenName;
  String? kindergartenAddress;
  String? sendWeight;
  String? successWeight;
  String? sendNumberPack;
  String? successNumberPack;
  String? timeOfShipment;
  String? timeTaken;
  String? theSender;
  String? receiver;
  String? status;
  String? pack;
  String? measurementType;

  factory CookerProduct.fromJson(Map<String, dynamic> json) => CookerProduct(
        id: json["id"].toString(),
        productName: json["productName"].toString(),
        productId: json["productId"].toString(),
        companyName: json["companyName"].toString(),
        orderNumber: json["orderNumber"].toString(),
        kindergartenName: json["kindergartenName"].toString(),
        kindergartenAddress: json["kindergartenAddress"].toString(),
        sendWeight: json["sendWeight"].toString(),
        successWeight: json["successWeight"].toString(),
        sendNumberPack: json["sendNumberPack"].toString(),
        successNumberPack: json["successNumberPack"].toString(),
        timeOfShipment: json["timeOfShipment"].toString(),
        timeTaken: json["timeTaken"].toString(),
        theSender: json["theSender"].toString(),
        receiver: json["receiver"].toString(),
        status: json["status"].toString(),
        pack: json["pack"].toString(),
        measurementType: json["measurementType"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "productId": productId,
        "companyName": companyName,
        "orderNumber": orderNumber,
        "kindergartenName": kindergartenName,
        "kindergartenAddress": kindergartenAddress,
        "sendWeight": sendWeight,
        "successWeight": successWeight,
        "sendNumberPack": sendNumberPack,
        "successNumberPack": successNumberPack,
        "timeOfShipment": timeOfShipment,
        "timeTaken": timeTaken,
        "theSender": theSender,
        "receiver": receiver,
        "status": status,
        "pack": pack,
        "measurementType": measurementType,
      };
}
