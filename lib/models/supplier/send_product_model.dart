
class SendProduct {
    SendProduct({
        this.comment,
        this.companyId,
        this.measurementType,
        this.numberPack,
        this.orderNumber,
        this.pack,
        this.paymentStatus,
        this.price,
        this.productId,
        this.typeOfPayment,
        this.weightPack,
    });

    String? comment;
    int? companyId;
    String? measurementType;
    int? numberPack;
    String? orderNumber;
    double? pack;
    bool? paymentStatus;
    double? price;
    int? productId;
    bool? typeOfPayment;
    double? weightPack;

    factory SendProduct.fromJson(Map<String, dynamic> json) => SendProduct(
        comment: json["comment"],
        companyId: json["companyId"],
        measurementType: json["measurementType"],
        numberPack: json["numberPack"],
        orderNumber: json["orderNumber"],
        pack: json["pack"],
        paymentStatus: json["paymentStatus"],
        price: json["price"],
        productId: json["productId"],
        typeOfPayment: json["typeOfPayment"],
        weightPack: json["weightPack"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "companyId": companyId,
        "measurementType": measurementType,
        "numberPack": numberPack,
        "orderNumber": orderNumber,
        "pack": pack,
        "paymentStatus": paymentStatus,
        "price": price,
        "productId": productId,
        "typeOfPayment": typeOfPayment,
        
        "weightPack": weightPack,
    };
}
