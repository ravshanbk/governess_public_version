class SendProduct {
  SendProduct({
    this.comment,
    this.numberPack,
    this.paymentStatus,
    this.price,
    this.typeOfPayment,
    this.weight,
  });

  String? comment;

  double? numberPack;

  bool? paymentStatus;
  double? price;

  bool? typeOfPayment;
  double? weight;

  factory SendProduct.fromJson(Map<String, dynamic> json) => SendProduct(
        comment: json["comment"],
        numberPack: json["numberPack"],
        paymentStatus: json["paymentStatus"],
        price: json["price"],
        typeOfPayment: json["typeOfPayment"],
        weight: json["weightPack"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "numberPack": numberPack,
        "paymentStatus": paymentStatus,
        "price": price,
        "typeOfPayment": typeOfPayment,
        "weightPack": weight,
      };
}
