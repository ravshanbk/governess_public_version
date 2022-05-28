class Tajriba {
  String? id;
  String? supplierName;
  String? productName;

  int? productId;
  int? companyId;
  String? companyName;

  int? orderId;
  String? orderNumber;
  double? weight;

  double? successWeight;
  double? numberPack;
double? successNumberPack;

  int? requestDate;
  String? status;
  double? pack;
  
  String? measurementType;

  Tajriba(
      {this.id,
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
      this.measurementType});

  Tajriba.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierName = json['supplierName'];
    productName = json['productName'];
    productId = json['productId'];
    companyId = json['companyId'];
    companyName = json['companyName'];
    orderId = json['orderId'];
    orderNumber = json['orderNumber'];
    weight = json['weight'];
    successWeight = json['successWeight'].toDouble();
    numberPack = json['numberPack'];
    successNumberPack = json['successNumberPack'].toDouble();
    requestDate = json['requestDate'];
    status = json['status'];
    pack = json['pack'].toDouble();
    measurementType = json['measurementType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['supplierName'] = this.supplierName;
    data['productName'] = this.productName;
    data['productId'] = this.productId;
    data['companyId'] = this.companyId;
    data['companyName'] = this.companyName;
    data['orderId'] = this.orderId;
    data['orderNumber'] = this.orderNumber;
    data['weight'] = this.weight;
    data['successWeight'] = this.successWeight;
    data['numberPack'] = this.numberPack;
    data['successNumberPack'] = this.successNumberPack;
    data['requestDate'] = this.requestDate;
    data['status'] = this.status;
    data['pack'] = this.pack;
    data['measurementType'] = this.measurementType;
    return data;
  }
}
