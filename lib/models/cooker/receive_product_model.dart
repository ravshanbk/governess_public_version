
class ReceiveProductModel {
    ReceiveProductModel({
        this.comment,
        this.numberPack,
        this.weight,
    
    });

    String? comment;
   double? numberPack;
    double? weight;

    factory ReceiveProductModel.fromJson(Map<String, dynamic> json) => ReceiveProductModel(
        comment: json["comment"],
        numberPack: json["numberPack"],
        weight: json["weightPack"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "numberPack": numberPack,
        "weight": weight,
    };
}
