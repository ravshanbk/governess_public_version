
class SendProduct {
    SendProduct({
        this.comment,
        this.companyId,
        this.measurementType,
        this.numberPack,
        this.orderNumber,
        this.pack,
        this.price,
        this.productId,
        this.weightPack,
    });

    String? comment;
    num? companyId;
    String? measurementType;
    int? numberPack;
    String? orderNumber;
    num? pack;
    num? price;
    num? productId;
    num? weightPack;

    factory SendProduct.fromJson(Map<String, dynamic> json) => SendProduct(
        comment: json["comment"],
        companyId: json["companyId"],
        measurementType: json["measurementType"],
        numberPack: json["numberPack"],
        orderNumber: json["orderNumber"],
        pack: json["pack"],
        price: json["price"],
        productId: json["productId"],
        weightPack: json["weightPack"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "companyId": companyId,
        "measurementType": measurementType,
        "numberPack": numberPack,
        "orderNumber": orderNumber,
        "pack": pack,
        "price": price,
        "productId": productId,
        "weightPack": weightPack,
    };
}
