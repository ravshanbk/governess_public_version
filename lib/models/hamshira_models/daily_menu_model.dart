class DailyMenu {
  DailyMenu({
    this.id,
    this.name,
    this.createDate,
    this.updateDate,
    this.multiMenuName,
    this.date,
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
  dynamic perDayDto;
  List<MealTimeStandardResponseSaveDtoList>?
      mealTimeStandardResponseSaveDtoList;
  List<NumberToGuess>? numberToGuess;

  factory DailyMenu.fromJson(Map<String, dynamic> json) => DailyMenu(
        id: json["id"],
        name: json["name"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        multiMenuName: json["multiMenuName"],
        date: json["date"],
        perDayDto: json["perDayDTO"],
        mealTimeStandardResponseSaveDtoList:
            json["mealTimeStandardResponseSaveDTOList"] == null
                ? null
                : List<MealTimeStandardResponseSaveDtoList>.from(
                    json["mealTimeStandardResponseSaveDTOList"].map((x) =>
                        MealTimeStandardResponseSaveDtoList.fromJson(x))),
        numberToGuess: json["numberToGuess"] == null
            ? null
            : List<NumberToGuess>.from(
                json["numberToGuess"].map((x) => NumberToGuess.fromJson(x))),
      );
}

class MealTimeStandardResponseSaveDtoList {
  MealTimeStandardResponseSaveDtoList({
    this.id,
    this.mealTimeName,
    this.mealAgeStandardResponseSaveDtoList,
  });

  num? id;
  String? mealTimeName;
  List<MealAgeStandardResponseSaveDtoList>? mealAgeStandardResponseSaveDtoList;

  factory MealTimeStandardResponseSaveDtoList.fromJson(
          Map<String, dynamic> json) =>
      MealTimeStandardResponseSaveDtoList(
        id: json["id"],
        mealTimeName: json["mealTimeName"],
        mealAgeStandardResponseSaveDtoList:
            json["mealAgeStandardResponseSaveDTOList"] == null
                ? null
                : List<MealAgeStandardResponseSaveDtoList>.from(
                    json["mealAgeStandardResponseSaveDTOList"].map(
                        (x) => MealAgeStandardResponseSaveDtoList.fromJson(x))),
      );
}

class MealAgeStandardResponseSaveDtoList {
  MealAgeStandardResponseSaveDtoList({
    this.id,
    this.name,
    this.image,
    this.ageStandardResponseSaveDtoList,
  });

  num? id;
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
            json["ageStandardResponseSaveDTOList"] == null
                ? null
                : List<AgeStandardResponseSaveDtoList>.from(
                    json["ageStandardResponseSaveDTOList"].map(
                        (x) => AgeStandardResponseSaveDtoList.fromJson(x))),
      );
}

class AgeStandardResponseSaveDtoList {
  AgeStandardResponseSaveDtoList({
    this.id,
    this.weight,
    this.ageGroupName,
  });

  num? id;
  num? weight;
  String? ageGroupName;

  factory AgeStandardResponseSaveDtoList.fromJson(Map<String, dynamic> json) =>
      AgeStandardResponseSaveDtoList(
        id: json["id"],
        weight: json["weight"],
        ageGroupName: json["ageGroupName"],
      );
}

class NumberToGuess {
  NumberToGuess({
    this.id,
    this.ageGroupId,
    this.ageGroupName,
    this.number,
  });

  num? id;
  num? ageGroupId;
  String? ageGroupName;
  num? number;

  factory NumberToGuess.fromJson(Map<String, dynamic> json) => NumberToGuess(
        id: json["id"],
        ageGroupId: json["ageGroupId"],
        ageGroupName: json["ageGroupName"],
        number: json["number"],
      );
}
