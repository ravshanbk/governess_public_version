// To parse this JSON data, do
//
//     final garbage = garbageFromJson(jsonString);

import 'dart:convert';

List<Garbage> garbageFromJson(String str) =>
    List<Garbage>.from(json.decode(str).map((x) => Garbage.fromJson(x)));

String garbageToJson(List<Garbage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Garbage {
  Garbage({
    this.id,
    this.productName,
    this.weight,
    this.createDate,
    this.updateDate,
    this.createdByName,
    this.acceptByName,
    this.acceptDate,
    this.comment,
    this.status,
    this.kindergartenName,
  });

  int? id;
  String? productName;
  double? weight;
  int? createDate;
  int? updateDate;
  String? createdByName;
  String? acceptByName;
  int? acceptDate;
  String? comment;
  String? status;
  String? kindergartenName;

  factory Garbage.fromJson(Map<String, dynamic> json) => Garbage(
        id: json["id"],
        productName: json["productName"],
        weight: json["weight"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        createdByName: json["createdByName"],
        acceptByName: json["acceptByName"],
        acceptDate: json["acceptDate"] == null ? null : json["acceptDate"],
        comment: json["comment"],
        status: json["status"],
        kindergartenName: json["kindergartenName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "weight": weight,
        "createDate": createDate,
        "updateDate": updateDate,
        "createdByName": createdByName,
        "acceptByName": acceptByName,
        "acceptDate": acceptDate == null ? null : acceptDate,
        "comment": comment,
        "status": status,
        "kindergartenName": kindergartenName,
      };
}
