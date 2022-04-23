// To parse this JSON data, do
//
//     final dailyMenu = dailyMenuFromJson(jsonString);

import 'dart:convert';

DailyMenu dailyMenuFromJson(String str) => DailyMenu.fromJson(json.decode(str));

String dailyMenuToJson(DailyMenu data) => json.encode(data.toJson());

class DailyMenu {
    DailyMenu({
        this.id,
        this.name,
        this.createDate,
        this.updateDate,
        this.multiMenuName,
        this.date,
        this.status,
        this.confirmation,
        this.perDayDto,
        this.mealTimeStandardResponseSaveDtoList,
        this.numberToGuess,
    });

    int? id;
    String? name;
    int? createDate;
    int? updateDate;
    String? multiMenuName;
    int? date;
    String? status;
    bool? confirmation;
    dynamic perDayDto;
    List<MealTimeStandardResponseSaveDtoList>? mealTimeStandardResponseSaveDtoList;
    List<dynamic>? numberToGuess;

    factory DailyMenu.fromJson(Map<String, dynamic> json) => DailyMenu(
        id: json["id"],
        name: json["name"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        multiMenuName: json["multiMenuName"],
        date: json["date"],
        status: json["status"],
        confirmation: json["confirmation"],
        perDayDto: json["perDayDTO"],
        mealTimeStandardResponseSaveDtoList: List<MealTimeStandardResponseSaveDtoList>.from(json["mealTimeStandardResponseSaveDTOList"].map((x) => MealTimeStandardResponseSaveDtoList.fromJson(x))),
        numberToGuess: List<dynamic>.from(json["numberToGuess"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createDate": createDate,
        "updateDate": updateDate,
        "multiMenuName": multiMenuName,
        "date": date,
        "status": status,
        "confirmation": confirmation,
        "perDayDTO": perDayDto,
        "mealTimeStandardResponseSaveDTOList": List<dynamic>.from(mealTimeStandardResponseSaveDtoList!.map((x) => x.toJson())),
        "numberToGuess": List<dynamic>.from(numberToGuess!.map((x) => x)),
    };
}

class MealTimeStandardResponseSaveDtoList {
    MealTimeStandardResponseSaveDtoList({
        this.id,
        this.mealTimeName,
        this.mealAgeStandardResponseSaveDtoList,
    });

    int? id;
    String? mealTimeName;
    List<MealAgeStandardResponseSaveDtoList>? mealAgeStandardResponseSaveDtoList;

    factory MealTimeStandardResponseSaveDtoList.fromJson(Map<String, dynamic> json) => MealTimeStandardResponseSaveDtoList(
        id: json["id"],
        mealTimeName: json["mealTimeName"],
        mealAgeStandardResponseSaveDtoList: List<MealAgeStandardResponseSaveDtoList>.from(json["mealAgeStandardResponseSaveDTOList"].map((x) => MealAgeStandardResponseSaveDtoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mealTimeName": mealTimeName,
        "mealAgeStandardResponseSaveDTOList": List<dynamic>.from(mealAgeStandardResponseSaveDtoList!.map((x) => x.toJson())),
    };
}

class MealAgeStandardResponseSaveDtoList {
    MealAgeStandardResponseSaveDtoList({
        this.id,
        this.name,
        this.image,
        this.ageStandardResponseSaveDtoList,
    });

    int? id;
    String? name;
    String? image;
    List<AgeStandardResponseSaveDtoList>? ageStandardResponseSaveDtoList;

    factory MealAgeStandardResponseSaveDtoList.fromJson(Map<String, dynamic> json) => MealAgeStandardResponseSaveDtoList(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        ageStandardResponseSaveDtoList: List<AgeStandardResponseSaveDtoList>.from(json["ageStandardResponseSaveDTOList"].map((x) => AgeStandardResponseSaveDtoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "ageStandardResponseSaveDTOList": List<dynamic>.from(ageStandardResponseSaveDtoList!.map((x) => x.toJson())),
    };
}

class AgeStandardResponseSaveDtoList {
    AgeStandardResponseSaveDtoList({
        this.id,
        this.weight,
        this.ageGroupName,
    });

    int? id;
    double? weight;
    String? ageGroupName;

    factory AgeStandardResponseSaveDtoList.fromJson(Map<String, dynamic> json) => AgeStandardResponseSaveDtoList(
        id: json["id"],
        weight: json["weight"],
        ageGroupName: json["ageGroupName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "weight": weight,
        "ageGroupName": ageGroupName,
    };
}
