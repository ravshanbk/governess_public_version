// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.createDate,
    this.updateDate,
    this.sendDate,
    this.orderNumber,
    this.price,
    this.pack,
    this.numberPack,
    this.weightPack,
    this.status,
    this.measurementType,
    this.companyName,
    this.companyId,
    this.productId,
    this.productName,
    this.comment,
    this.paymentStatus,
    this.typeOfPayment,
  });

  String? id;
  int? createDate;
  int? updateDate;

  int? sendDate;
  String? orderNumber;
  dynamic price;

  double? pack;
  double? numberPack;
  double? weightPack;

  String? status;
  String? measurementType;
  String? companyName;

  int? companyId;
  int? productId;
  String? productName;

  dynamic comment;
  dynamic paymentStatus;
  dynamic typeOfPayment;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        sendDate: json["sendDate"],
        orderNumber: json["orderNumber"],
        price: json["price"],
        pack: json["pack"],
        numberPack: json["numberPack"],
        weightPack: json["weightPack"],
        status: json["status"],
        measurementType: json["measurementType"],
        companyName: json["companyName"],
        companyId: json["companyId"],
        productId: json["productId"],
        productName: json["productName"],
        comment: json["comment"],
        paymentStatus: json["paymentStatus"],
        typeOfPayment: json["typeOfPayment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createDate": createDate,
        "updateDate": updateDate,

        "sendDate": sendDate,
        "orderNumber": orderNumber,
        "price": price,

        "pack": pack,
        "numberPack": numberPack,
        "weightPack": weightPack,

        "status": status,
        "measurementType": measurementType,
        "companyName": companyName,

        "companyId": companyId,
        "productId": productId,
        "productName": productName,
        
        "comment": comment,
        "paymentStatus": paymentStatus,
        "typeOfPayment": typeOfPayment,
      };
}
