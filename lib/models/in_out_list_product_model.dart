class InoutListProduct {
  InoutListProduct({
    this.inOutList,
    this.productName,
    this.weight,
  });

  List<InOutList>? inOutList;
  String? productName;
  int? weight;

  factory InoutListProduct.fromJson(Map<String, dynamic> json) =>
      InoutListProduct(
        inOutList: List<InOutList>.from(
            json["inOutList"].map((x) => InOutList.fromJson(x))),
        productName: json["productName"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "inOutList": List<dynamic>.from(inOutList!.map((x) => x.toJson())),
        "productName": productName,
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
  });

  dynamic id;
  int? enterDate;
  int? price;
  int? pack;
  int? numberPack;
  int? weightPack;
  String? measurementType;

  factory InOutList.fromJson(Map<String, dynamic> json) => InOutList(
        id: json["id"],
        enterDate: json["enterDate"],
        price: json["price"],
        pack: json["pack"],
        numberPack: json["numberPack"],
        weightPack: json["weightPack"],
        measurementType: json["measurementType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "enterDate": enterDate,
        "price": price,
        "pack": pack,
        "numberPack": numberPack,
        "weightPack": weightPack,
        "measurementType": measurementType,
      };
}
