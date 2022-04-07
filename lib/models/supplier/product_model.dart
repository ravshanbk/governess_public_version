
class Product {
    Product({
        this.id,
        this.createDate,
        this.updateDate,
        this.sendDate,
        this.orderNumber,
        this.price,
        this.pack,
        this.numberPack,
        this.weightPack,
        this.status,
        this.measurementType,
        this.companyName,
        this.companyId,
        this.productId,
        this.productName,
        this.comment,
    });

    int? id;
    int? createDate;
    int? updateDate;
    int? sendDate;
    String? orderNumber;
    dynamic price;
    num? pack;
    num? numberPack;
    double? weightPack;
    String? status;
    String? measurementType;
    String? companyName;
    int? companyId;
    int? productId;
    String? productName;
    dynamic comment;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        createDate: json["createDate"] == null ? null : json["createDate"],
        updateDate: json["updateDate"] == null ? null : json["updateDate"],
        sendDate: json["sendDate"] == null ? null : json["sendDate"],
        orderNumber: json["orderNumber"] == null ? null : json["orderNumber"],
        price: json["price"],
        pack: json["pack"] == null ? null : json["pack"],
        numberPack: json["numberPack"] == null ? null : json["numberPack"],
        weightPack: json["weightPack"] == null ? null : json["weightPack"].toDouble(),
        status: json["status"] == null ? null : json["status"],
        measurementType: json["measurementType"] == null ? null : json["measurementType"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        companyId: json["companyId"] == null ? null : json["companyId"],
        productId: json["productId"] == null ? null : json["productId"],
        productName: json["productName"] == null ? null : json["productName"],
        comment: json["comment"],
    );

}
