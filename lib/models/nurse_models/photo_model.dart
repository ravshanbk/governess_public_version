

import 'dart:convert';

PhotoNumerOfChildren menuInfoFromJson(String str) => PhotoNumerOfChildren.fromJson(json.decode(str));

String menuInfoToJson(PhotoNumerOfChildren data) => json.encode(data.toJson());

class PhotoNumerOfChildren {
  PhotoNumerOfChildren({
    this.id,
    this.bytes,
  });

  int? id;
  String? bytes;

  factory PhotoNumerOfChildren.fromJson(Map<String, dynamic> json) => PhotoNumerOfChildren(
        id: json["id"],
        bytes: json["bytes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bytes": bytes,
      };
}
