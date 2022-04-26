class CookerProduct {
  CookerProduct({
    this.inOutList,
    this.productName,
    this.productId,
    this.weight,
  });

  List<InOutList>? inOutList;
  String? productName;
  int? productId;
  double? weight;

  factory CookerProduct.fromJson(Map<String, dynamic> json) => CookerProduct(
        inOutList: List<InOutList>.from(
            json["inOutList"].map((x) => InOutList.fromJson(x))),
        productName: json["productName"],
        productId: json["productId"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "inOutList": List<dynamic>.from(inOutList!.map((x) => x.toJson())),
        "productName": productName,
        "productId": productId,
        "weight": weight,
      };
}

class InOutList {
  InOutList({
    this.id,
    this.enterDate,
    this.price,
    this.pack,
    this.numberPack,
    this.weightPack,
    this.measurementType,
    this.status,
  });

  String? id;
  int? enterDate;
  double? price;
  double? pack;
  double? numberPack;
  double? weightPack;
  String? measurementType;
  dynamic status;

  factory InOutList.fromJson(Map<String, dynamic> json) => InOutList(
        id: json["id"],
        enterDate: json["enterDate"],
        price: json["price"],
        pack: json["pack"],
        numberPack: json["numberPack"],
        weightPack: json["weightPack"],
        measurementType: json["measurementType"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "enterDate": enterDate,
        "price": price,
        "pack": pack,
        "numberPack": numberPack,
        "weightPack": weightPack,
        "measurementType": measurementType,
        "status": status,
      };
}
