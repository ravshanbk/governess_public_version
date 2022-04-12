// To parse this JSON data, do
//
//     final application = applicationFromJson(jsonString);

import 'dart:convert';

Application applicationFromJson(String str) => Application.fromJson(json.decode(str));

String applicationToJson(Application data) => json.encode(data.toJson());

class Application {
    Application({
        this.accountNumber,
        this.companyName,
        this.districtId,
        this.inn,
        this.leaderFatherName,
        this.leaderName,
        this.leaderPhoneNumber,
        this.leaderSurname,
        this.mfo,
        this.password,
        this.phoneNumber,
        this.street,
        this.userName,
    });

    String? accountNumber;
    String? companyName;
    int? districtId;
    String? inn;
    String? leaderFatherName;
    String? leaderName;
    String? leaderPhoneNumber;
    String? leaderSurname;
    String? mfo;
    String? password;
    String? phoneNumber;
    String? street;
    String? userName;

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        accountNumber: json["accountNumber"],
        companyName: json["companyName"],
        districtId: json["districtId"],
        inn: json["inn"],
        leaderFatherName: json["leaderFatherName"],
        leaderName: json["leaderName"],
        leaderPhoneNumber: json["leaderPhoneNumber"],
        leaderSurname: json["leaderSurname"],
        mfo: json["mfo"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        street: json["street"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "companyName": companyName,
        "districtId": districtId,
        "inn": inn,
        "leaderFatherName": leaderFatherName,
        "leaderName": leaderName,
        "leaderPhoneNumber": leaderPhoneNumber,
        "leaderSurname": leaderSurname,
        "mfo": mfo,
        "password": password,
        "phoneNumber": phoneNumber,
        "street": street,
        "userName": userName,
    };
}
