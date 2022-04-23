// To parse this JSON data, do
//
//     final numberOfChildren2 = numberOfChildren2FromJson(jsonString);

import 'dart:convert';

NumberOfChildren numberOfChildren2FromJson(String str) => NumberOfChildren.fromJson(json.decode(str));

String numberOfChildren2ToJson(NumberOfChildren data) => json.encode(data.toJson());

class NumberOfChildren {
    NumberOfChildren({
        this.district,
        this.perDayList,
    });

    District? district;
    List<PerDayList>? perDayList;

    factory NumberOfChildren.fromJson(Map<String, dynamic> json) => NumberOfChildren(
        district: District.fromJson(json["district"]),
        perDayList: List<PerDayList>.from(json["perDayList"].map((x) => PerDayList.fromJson(x))),
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
    });

    int? id;
    String? name;

    factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class PerDayList {
    PerDayList({
        this.id,
        this.createDate,
        this.updateDate,
        this.createdBy,
        this.updateBy,
        this.status,
        this.numberOfChildrenDtoList,
        this.kindergartenId,
        this.kindergartenName,
    });

    int? id;
    int? createDate;
    int? updateDate;
    int? createdBy;
    int? updateBy;
    String? status;
    List<NumberOfChildrenDtoList>? numberOfChildrenDtoList;
    int? kindergartenId;
    String? kindergartenName;

    factory PerDayList.fromJson(Map<String, dynamic> json) => PerDayList(
        id: json["id"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        createdBy: json["createdBy"],
        updateBy: json["updateBy"],
        status: json["status"],
        numberOfChildrenDtoList: List<NumberOfChildrenDtoList>.from(json["numberOfChildrenDTOList"].map((x) => NumberOfChildrenDtoList.fromJson(x))),
        kindergartenId: json["kindergartenId"],
        kindergartenName: json["kindergartenName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createDate": createDate,
        "updateDate": updateDate,
        "createdBy": createdBy,
        "updateBy": updateBy,
        "status": status,
        "numberOfChildrenDTOList": List<dynamic>.from(numberOfChildrenDtoList!.map((x) => x.toJson())),
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

    factory NumberOfChildrenDtoList.fromJson(Map<String, dynamic> json) => NumberOfChildrenDtoList(
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
