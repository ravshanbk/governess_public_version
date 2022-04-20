
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

    num? id;
    num? createDate;
    num? updateDate;
    int? sendDate;
    String? orderNumber;
    dynamic price;
    num? pack;
    num? numberPack;
    num? weightPack;
    String? status;
    String? measurementType;
    String? companyName;
    num? companyId;
    num? productId;
    String? productName;
    dynamic comment;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        sendDate: json["sendDate"],
        orderNumber: json["orderNumber"],
        price: json["price"],
        pack: json["pack"],
        numberPack: json["numberPack"],
        weightPack: json["weightPack"],
        status: json["status"],
        measurementType: json["measurementType"],
        companyName: json["companyName"],
        companyId: json["companyId"],
        productId: json["productId"],
        productName: json["productName"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createDate": createDate,
        "updateDate": updateDate,
        "sendDate": sendDate,
        "orderNumber": orderNumber,
        "price": price,
        "pack": pack,
        "numberPack": numberPack,
        "weightPack": weightPack,
        "status": status,
        "measurementType": measurementType,
        "companyName": companyName,
        "companyId": companyId,
        "productId": productId,
        "productName": productName,
        "comment": comment,
    };
}
