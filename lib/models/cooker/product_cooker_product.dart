// To parse this JSON data, do
//
//     final balancer = balancerFromJson(jsonString);

import 'dart:convert';

List<Balancer> balancerFromJson(String str) =>
    List<Balancer>.from(json.decode(str).map((x) => Balancer.fromJson(x)));

String balancerToJson(List<Balancer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Balancer {
  Balancer({
    this.productName,
    this.productId,
    this.weight,
    this.numberPack,
    this.pack,
  });

  String? productName;
  int? productId;
  double? weight;
  double? numberPack;
  double? pack;

  factory Balancer.fromJson(Map<String, dynamic> json) => Balancer(
        productName: json["productName"],
        productId: json["productId"],
        weight: json["weight"].toDouble(),
        numberPack: json["numberPack"].toDouble(),
        pack: json["pack"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productId": productId,
        "weight": weight,
        "numberPack": numberPack,
        "pack": pack,
      };
}
