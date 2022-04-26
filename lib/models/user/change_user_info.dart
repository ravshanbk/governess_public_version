// To parse this JSON data, do
//
//     final changUserInfo = changUserInfoFromJson(jsonString);

import 'dart:convert';

ChangUserInfo changUserInfoFromJson(String str) => ChangUserInfo.fromJson(json.decode(str));

String changUserInfoToJson(ChangUserInfo data) => json.encode(data.toJson());

class ChangUserInfo {
    ChangUserInfo({
        this.newPassword,
        this.oldPassword,
        this.username,
    });

    String? newPassword;
    String? oldPassword;
    String? username;

    factory ChangUserInfo.fromJson(Map<String, dynamic> json) => ChangUserInfo(
        newPassword: json["newPassword"],
        oldPassword: json["oldPassword"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "newPassword": newPassword,
        "oldPassword": oldPassword,
        "username": username,
    };
}
