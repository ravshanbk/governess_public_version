class MealInfo {
  MealInfo({
    this.id,
    this.name,
    this.weight,
    this.mealCategoryId,
    this.mealCategoryName,
    this.productMeals,
    this.ingredientDto,
    this.attachment,
    this.comment,
  });

  int? id;
  String? name;
  double? weight;//
  int? mealCategoryId;
  String? mealCategoryName;
  List<ProductMeal>? productMeals;
  IngredientDto? ingredientDto;
  Attachment? attachment;
  String? comment;

  factory MealInfo.fromJson(Map<String, dynamic> json) => MealInfo(
        id: json["id"],
        name: json["name"],
        weight: json["weight"],
        mealCategoryId: json["mealCategoryId"],
        mealCategoryName: json["mealCategoryName"],
        productMeals: List<ProductMeal>.from(
            json["productMeals"].map((x) => ProductMeal.fromJson(x))),
        ingredientDto: IngredientDto.fromJson(json["ingredientDTO"]),
        attachment: Attachment.fromJson(json["attachment"]),
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "weight": weight,
        "mealCategoryId": mealCategoryId,
        "mealCategoryName": mealCategoryName,
        "productMeals":
            List<dynamic>.from(productMeals!.map((x) => x.toJson())),
        "ingredientDTO": ingredientDto!.toJson(),
        "attachment": attachment!.toJson(),
        "comment": comment,
      };
}

class Attachment {
  Attachment({
    this.id,
    this.bytes,
  });

  int? id;
  String? bytes;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        bytes: json["bytes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bytes": bytes,
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
 double? weight;//
 double? withoutExit;//
  int? productId;
  String? name;

  factory ProductMeal.fromJson(Map<String, dynamic> json) => ProductMeal(
        id: json["id"],
        weight: json["weight"],
        withoutExit: json["withoutExit"],
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
