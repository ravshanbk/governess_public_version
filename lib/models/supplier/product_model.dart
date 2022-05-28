/////////////////////////
///
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
    this.supplierName,
    this.productName,
    this.productId,
    this.companyId,
    this.companyName,
    this.orderId,
    this.orderNumber,
    this.weight,
    this.successWeight,
    this.numberPack,
    this.successNumberPack,
    this.requestDate,
    this.status,
    this.pack,
    this.measurementType,
  });

  String? id;
  String? supplierName;
  String? productName;
  String? productId;
  String? companyId;
  String? companyName;
  String? orderId;
  String? orderNumber;
  String? weight;
  String? successWeight;
  String? numberPack;
  String? successNumberPack;
  String? requestDate;
  String? status;
  String? pack;
  String? measurementType;

  factory Product.fromJson(Map<String, dynamic> json) {

    return Product(
      id: json["id"].toString(),
      supplierName: json["supplierName"].toString(),
      productName: json["productName"].toString(),
      productId: json["productId"].toString(),
      companyId: json["companyId"].toString(),
      companyName: json["companyName"].toString(),
      orderId: json["orderId"].toString(),
      orderNumber: json["orderNumber"].toString(),
      weight: json["weight"].toString(),
      successWeight: json["successWeight"].toString(),
      numberPack: json["numberPack"].toString(),
      successNumberPack: json["successNumberPack"].toString(),
      requestDate: json["requestDate"].toString(),
      status: json["status"].toString(),
      pack: json["pack"].toString(),
      measurementType: json["measurementType"].toString(),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "supplierName": supplierName ?? null,
        "productName": productName ?? null,
        "productId": productId ?? null,
        "companyId": companyId ?? null,
        "companyName": companyName ?? null,
        "orderId": orderId ?? null,
        "orderNumber": orderNumber ?? null,
        "weight": weight ?? null,
        "successWeight": successWeight ?? null,
        "numberPack": numberPack ?? null,
        "successNumberPack": successNumberPack ?? null,
        "requestDate": requestDate ?? null,
        "status": status ?? null,
        "pack": pack ?? null,
        "measurementType": measurementType ?? null,
      };
}
