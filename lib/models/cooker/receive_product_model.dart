
class ReceiveProductModel {
    ReceiveProductModel({
        this.comment,
        this.numberPack,
        this.weightPack,
    });

    String? comment;
    int? numberPack;
    int? weightPack;

    factory ReceiveProductModel.fromJson(Map<String, dynamic> json) => ReceiveProductModel(
        comment: json["comment"],
        numberPack: json["numberPack"],
        weightPack: json["weightPack"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "numberPack": numberPack,
        "weightPack": weightPack,
    };
}
