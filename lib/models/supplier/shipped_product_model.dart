// To parse this JSON data, do
//
//     final shippedProduct = shippedProductFromJson(jsonString);

import 'dart:convert';

List<ShippedProduct> shippedProductFromJson(String str) =>
    List<ShippedProduct>.from(
        json.decode(str).map((x) => ShippedProduct.fromJson(x)));

String shippedProductToJson(List<ShippedProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShippedProduct {
  ShippedProduct({
    this.id,
    this.productName,
    this.productId,
    this.companyName,
    this.companyId,
    this.orderNumber,
    this.orderId,
    this.sendWeight,
    this.successWeight,
    this.sendNumberPack,
    this.successNumberPack,
    this.price,
    this.timeOfShipment,
    this.timeTaken,
    this.theSender,
    this.receiver,
    this.status,
    this.supplier,
    this.paymentStatus,
    this.typeOfPayment,
    this.pack,
    this.measurementType,
    this.comment,
  });

  String? id;
  String? productName;
  String? productId;
  String? companyName;
  String? companyId;
  String? orderNumber;
  String? orderId;
  String? sendWeight;
  String? successWeight;
  String? sendNumberPack;
  String? successNumberPack;
  String? price;
  String? timeOfShipment;
  dynamic timeTaken;
  String? theSender;
  String? receiver;
  String? status;
  String? supplier;
  String? paymentStatus;
  String? typeOfPayment;
  String? pack;
  String? measurementType;
  String? comment;

  factory ShippedProduct.fromJson(Map<String, dynamic> json) => ShippedProduct(
        id: json["id"].toString(),
        productName: json["productName"].toString(),
        productId: json["productId"].toString(),
        companyName: json["companyName"].toString(),
        companyId: json["companyId"].toString(),
        orderNumber: json["orderNumber"].toString(),
        orderId: json["orderId"].toString(),
        sendWeight: json["sendWeight"].toString(),
        successWeight: json["successWeight"].toString(),
        sendNumberPack: json["sendNumberPack"].toString(),
        successNumberPack: json["successNumberPack"].toString(),
        price: json["price"].toString(),
        timeOfShipment: json["timeOfShipment"].toString(),
        timeTaken: json["timeTaken"].toString(),
        theSender: json["theSender"].toString(),
        receiver: json["receiver"].toString(),
        status: json["status"].toString(),
        supplier: json["supplier"].toString(),
        paymentStatus: json["paymentStatus"].toString(),
        typeOfPayment: json["typeOfPayment"].toString(),
        pack: json["pack"].toString(),
        measurementType: json["measurementType"].toString(),
        comment: json["comment"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "productId": productId,
        "companyName": companyName,
        "companyId": companyId,
        "orderNumber": orderNumber,
        "orderId": orderId,
        "sendWeight": sendWeight,
        "successWeight": successWeight,
        "sendNumberPack": sendNumberPack,
        "successNumberPack": successNumberPack,
        "price": price,
        "timeOfShipment": timeOfShipment,
        "timeTaken": timeTaken,
        "theSender": theSender,
        "receiver": receiver,
        "status": status,
        "supplier": supplier,
        "paymentStatus": paymentStatus,
        "typeOfPayment": typeOfPayment,
        "pack": pack,
        "measurementType": measurementType,
        "comment": comment,
      };
}
