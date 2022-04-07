

class PostResModel {
    PostResModel({
        this.text,
        this.success,
        this.object,
    });

    String? text;
    bool? success;
    dynamic object;

    factory PostResModel.fromJson(Map<String, dynamic> json) => PostResModel(
        text: json["text"],
        success: json["success"],
        object: json["object"],
    );

   
}
