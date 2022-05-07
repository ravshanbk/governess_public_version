
import 'dart:convert';

AgeGroupIdAndNumber numberOfAgeGroupFromJson(String str) => AgeGroupIdAndNumber.fromJson(json.decode(str));

String numberOfAgeGroupToJson(AgeGroupIdAndNumber data) => json.encode(data.toJson());

class AgeGroupIdAndNumber {
    AgeGroupIdAndNumber({
        this.ageGroupId,
        this.id,
        this.number,
    });

    int? ageGroupId;
    int? id;
    int? number;

    factory AgeGroupIdAndNumber.fromJson(Map<String, dynamic> json) => AgeGroupIdAndNumber(
        ageGroupId: json["ageGroupId"],
        id: json["id"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "ageGroupId": ageGroupId,
        "id": id,
        "number": number,
    };
}
