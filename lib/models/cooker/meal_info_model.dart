// To parse this JSON data, do
//
//     final mealInfo = mealInfoFromJson(jsonString);

import 'dart:convert';

MealInfo mealInfoFromJson(String str) => MealInfo.fromJson(json.decode(str));

String mealInfoToJson(MealInfo data) => json.encode(data.toJson());

class MealInfo {
  MealInfo({
    this.id,
    this.name,
    this.weight,
    this.mealCategoryId,
    this.mealCategoryName,
    this.productMeals,
    this.ingredientDto,
    this.attachmentId,
    this.comment,
    this.perDayDto,
  });

  int? id;
  String? name;
  double? weight;
  int? mealCategoryId;
  String? mealCategoryName;
  List<ProductMeal>? productMeals;
  IngredientDto? ingredientDto;
  int? attachmentId;
  String? comment;
  PerDayDto? perDayDto;

  factory MealInfo.fromJson(Map<String, dynamic> json) => MealInfo(
        id: json["id"],
        name: json["name"],
        weight: json["weight"],
        mealCategoryId: json["mealCategoryId"],
        mealCategoryName: json["mealCategoryName"],
        productMeals: List<ProductMeal>.from(
            json["productMeals"].map((x) => ProductMeal.fromJson(x))),
        ingredientDto: IngredientDto.fromJson(json["ingredientDTO"]),
        attachmentId: json["attachmentId"],
        comment: json["comment"],
        perDayDto: PerDayDto.fromJson(json["perDayDTO"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "weight": weight,
        "mealCategoryId": mealCategoryId,
        "mealCategoryName": mealCategoryName,
        "productMeals": List<dynamic>.from(productMeals!.map((x) => x.toJson())),
        "ingredientDTO": ingredientDto!.toJson(),
        "attachmentId": attachmentId,
        "comment": comment,
        "perDayDTO": perDayDto!.toJson(),
      };
}

class IngredientDto {
  IngredientDto({
    this.id,
    this.protein,
    this.kcal,
    this.oil,
    this.carbohydrates,
  });

  dynamic id;
  double? protein;
  double? kcal;
  double? oil;
  double? carbohydrates;

  factory IngredientDto.fromJson(Map<String, dynamic> json) => IngredientDto(
        id: json["id"],
        protein: json["protein"].toDouble(),
        kcal: json["kcal"].toDouble(),
        oil: json["oil"].toDouble(),
        carbohydrates: json["carbohydrates"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "protein": protein,
        "kcal": kcal,
        "oil": oil,
        "carbohydrates": carbohydrates,
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

class ProductMeal {
  ProductMeal({
    this.id,
    this.weight,
    this.withoutExit,
    this.productId,
    this.name,
  });

  int? id;
  double? weight;
  double? withoutExit;
  int? productId;
  String? name;

  factory ProductMeal.fromJson(Map<String, dynamic> json) => ProductMeal(
        id: json["id"],
        weight: json["weight"].toDouble(),
        withoutExit: json["withoutExit"].toDouble(),
        productId: json["productId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weight": weight,
        "withoutExit": withoutExit,
        "productId": productId,
        "name": name,
      };
}
