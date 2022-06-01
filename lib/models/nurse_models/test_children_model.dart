
class NumberOfChildren {
  NumberOfChildren({
    this.district,
    this.perDayList,
  });

  District? district;
  List<PerDayList>? perDayList;

  factory NumberOfChildren.fromJson(Map<String, dynamic> json) => NumberOfChildren(
        district: District.fromJson(json["district"]),
        perDayList: List<PerDayList>.from(
            json["perDayList"].map((x) => PerDayList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "district": district!.toJson(),
        "perDayList": List<dynamic>.from(perDayList!.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.id,
    this.name,
    this.district,
  });

  int? id;
  String? name;
  List<dynamic>? district;

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
        district: List<dynamic>.from(json["district"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "district": List<dynamic>.from(district!.map((x) => x)),
      };
}

class PerDayList {
  PerDayList({
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
  dynamic createDate;
  dynamic date;
  dynamic updateDate;
  dynamic createdBy;
  dynamic updateBy;
  String? status;
  dynamic attachmentId;
  List<NumberOfChildrenDtoList>? numberOfChildrenDtoList;
  int? kindergartenId;
  String? kindergartenName;

  factory PerDayList.fromJson(Map<String, dynamic> json) => PerDayList(
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

  dynamic id;
  dynamic number;
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
