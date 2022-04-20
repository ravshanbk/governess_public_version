

class ResModel {
    ResModel({
        this.text,
        this.success,
        this.object,
    });

    String? text;
    bool? success;
    dynamic object;

    factory ResModel.fromJson(Map<String, dynamic> json) => ResModel(
        text: json["text"],
        success: json["success"],
        object: json["object"],
    );

   
}
