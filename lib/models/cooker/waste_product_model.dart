// To parse this JSON data, do
//
//     final wasteProduct = wasteProductFromJson(jsonString);

import 'dart:convert';

WasteProduct wasteProductFromJson(String str) =>
    WasteProduct.fromJson(json.decode(str));

String wasteProductToJson(WasteProduct data) => json.encode(data.toJson());

class WasteProduct {
  WasteProduct({
    this.comment,
    this.productId,
    this.weight,
    this.numberPack
  });
 double? numberPack;
  String? comment;
  int? productId;
  double? weight;

  factory WasteProduct.fromJson(Map<String, dynamic> json) => WasteProduct(
        comment: json["comment"],
        numberPack: json["numberPack"],
        productId: json["productId"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "productId": productId,
        "weight": weight,
        "numberPack": numberPack,
      };
}
