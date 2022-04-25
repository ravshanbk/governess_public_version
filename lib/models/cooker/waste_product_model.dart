// To parse this JSON data, do
//
//     final wasteProduct = wasteProductFromJson(jsonString);

import 'dart:convert';

WasteProduct wasteProductFromJson(String str) => WasteProduct.fromJson(json.decode(str));

String wasteProductToJson(WasteProduct data) => json.encode(data.toJson());

class WasteProduct {
    WasteProduct({
        this.comment,
        this.productId,
        this.weight,
    });

    String? comment;
    int? productId;
    int? weight;

    factory WasteProduct.fromJson(Map<String, dynamic> json) => WasteProduct(
        comment: json["comment"],
        productId: json["productId"],
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "productId": productId,
        "weight": weight,
    };
}
