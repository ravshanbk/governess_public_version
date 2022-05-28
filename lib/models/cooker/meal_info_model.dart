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

    factory MealInfo.fromJson(Map<String, dynamic> json) => MealInfo(
        id: json["id"],
        name: json["name"],
        weight: json["weight"].toDouble(),
        mealCategoryId: json["mealCategoryId"],
        mealCategoryName: json["mealCategoryName"],
        productMeals: List<ProductMeal>.from(json["productMeals"].map((x) => ProductMeal.fromJson(x))),
        ingredientDto: IngredientDto.fromJson(json["ingredientDTO"]),
        attachmentId: json["attachmentId"],
        comment: json["comment"],
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
