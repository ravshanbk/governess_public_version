// To parse this JSON data, do
//
//     final menuInfo = menuInfoFromJson(jsonString);

import 'dart:convert';

Sirileze menuInfoFromJson(String str) => Sirileze.fromJson(json.decode(str));

String menuInfoToJson(Sirileze data) => json.encode(data.toJson());

class Sirileze {
  Sirileze({
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
  PerDayDto? perDayDto;
  List<MealTimeStandardResponseSaveDtoList>? mealTimeStandardResponseSaveDtoList;
  dynamic numberToGuess;

  factory Sirileze.fromJson(Map<String, dynamic> json) => Sirileze(
        id: json["id"],
        name: json["name"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        multiMenuName: json["multiMenuName"],
        date: json["date"],
        status: json["status"],
        confirmation: json["confirmation"],
        perDayDto: PerDayDto.fromJson(json["perDayDTO"]),
        mealTimeStandardResponseSaveDtoList:
            List<MealTimeStandardResponseSaveDtoList>.from(
                json["mealTimeStandardResponseSaveDTOList"].map(
                    (x) => MealTimeStandardResponseSaveDtoList.fromJson(x))),
        numberToGuess: json["numberToGuess"],
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
        "perDayDTO": perDayDto?.toJson(),
        "mealTimeStandardResponseSaveDTOList": List<dynamic>.from(
            mealTimeStandardResponseSaveDtoList!.map((x) => x.toJson())),
        "numberToGuess": numberToGuess,
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

  factory MealTimeStandardResponseSaveDtoList.fromJson(
          Map<String, dynamic> json) =>
      MealTimeStandardResponseSaveDtoList(
        id: json["id"],
        mealTimeName: json["mealTimeName"],
        mealAgeStandardResponseSaveDtoList:
            List<MealAgeStandardResponseSaveDtoList>.from(
                json["mealAgeStandardResponseSaveDTOList"].map(
                    (x) => MealAgeStandardResponseSaveDtoList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mealTimeName": mealTimeName,
        "mealAgeStandardResponseSaveDTOList": List<dynamic>.from(
            mealAgeStandardResponseSaveDtoList!.map((x) => x.toJson())),
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

  factory MealAgeStandardResponseSaveDtoList.fromJson(
          Map<String, dynamic> json) =>
      MealAgeStandardResponseSaveDtoList(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        ageStandardResponseSaveDtoList:
            List<AgeStandardResponseSaveDtoList>.from(
                json["ageStandardResponseSaveDTOList"]
                    .map((x) => AgeStandardResponseSaveDtoList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "ageStandardResponseSaveDTOList": List<dynamic>.from(
            ageStandardResponseSaveDtoList!.map((x) => x.toJson())),
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

  factory AgeStandardResponseSaveDtoList.fromJson(Map<String, dynamic> json) =>
      AgeStandardResponseSaveDtoList(
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

class PerDayDto {
  PerDayDto({
    this.id,
    this.createDate,
    this.date,
    this.updateDate,
    this.createdBy,
    this.updateBy,
    this.status,
    this.attachmentId,
    this.numberOfChildrenDtoList,
    this.kindergartenId,
    this.kindergartenName,
  });

  dynamic id;
  int? createDate;
  int? date;
  int? updateDate;
  dynamic createdBy;
  dynamic updateBy;
  String? status;
  int? attachmentId;
  List<NumberOfChildrenDtoList>? numberOfChildrenDtoList;
  int? kindergartenId;
  String? kindergartenName;

  factory PerDayDto.fromJson(Map<String, dynamic> json) => PerDayDto(
        id: json["id"],
        createDate: json["createDate"],
        date: json["date"],
        updateDate: json["updateDate"],
        createdBy: json["createdBy"],
        updateBy: json["updateBy"],
        status: json["status"],
        attachmentId: json["attachmentId"],
        numberOfChildrenDtoList: List<NumberOfChildrenDtoList>.from(
            json["numberOfChildrenDTOList"]
                .map((x) => NumberOfChildrenDtoList.fromJson(x))),
        kindergartenId: json["kindergartenId"],
        kindergartenName: json["kindergartenName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createDate": createDate,
        "date": date,
        "updateDate": updateDate,
        "createdBy": createdBy,
        "updateBy": updateBy,
        "status": status,
        "attachmentId": attachmentId,
        "numberOfChildrenDTOList":
            List<dynamic>.from(numberOfChildrenDtoList!.map((x) => x.toJson())),
        "kindergartenId": kindergartenId,
        "kindergartenName": kindergartenName,
      };
}

class NumberOfChildrenDtoList {
  NumberOfChildrenDtoList({
    this.id,
    this.number,
    this.createDate,
    this.updateDate,
    this.ageGroupId,
    this.ageGroupName,
  });

  int? id;
  int? number;
  int? createDate;
  int? updateDate;
  int? ageGroupId;
  String? ageGroupName;

  factory NumberOfChildrenDtoList.fromJson(Map<String, dynamic> json) =>
      NumberOfChildrenDtoList(
        id: json["id"],
        number: json["number"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        ageGroupId: json["ageGroupId"],
        ageGroupName: json["ageGroupName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "createDate": createDate,
        "updateDate": updateDate,
        "ageGroupId": ageGroupId,
        "ageGroupName": ageGroupName,
      };
}
