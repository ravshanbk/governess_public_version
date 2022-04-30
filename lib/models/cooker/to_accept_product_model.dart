class CookerProduct {
  String? id;
  int? enterDate;
  double? price;
  double? weight;
  String? status;
  String? measurementType;
  double? weightPack;
  double? pack;
  double? numberPack;
  String? senderName;
  dynamic usersId;
  dynamic usersName;
  int? productId;
  String? productName;
  dynamic comment;

  CookerProduct(
      {this.id,
      this.enterDate,
      this.price,
      this.weight,
      this.status,
      this.measurementType,
      this.weightPack,
      this.pack,
      this.numberPack,
      this.senderName,
      this.usersId,
      this.usersName,
      this.productId,
      this.productName,
      this.comment});

  CookerProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enterDate = json['enterDate'];
    price = json['price'];
    weight = json['weight'];
    status = json['status'];
    measurementType = json['measurementType'];
    weightPack = json['weightPack'];
    pack = json['pack'];

    numberPack = json['numberPack'];

    senderName = json['senderName'];

    usersId = json['usersId'];

    usersName = json['usersName'];

    productId = json['productId'];

    productName = json['productName'];

    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enterDate'] = enterDate;
    data['price'] = price;
    data['weight'] = weight;
    data['status'] = status;
    data['measurementType'] = measurementType;
    data['weightPack'] = weightPack;
    data['pack'] = pack;
    data['numberPack'] = numberPack;
    data['senderName'] = senderName;
    data['usersId'] = usersId;
    data['usersName'] = usersName;
    data['productId'] = productId;
    data['productName'] = productName;
    data['comment'] = comment;
    return data;
  }
}
