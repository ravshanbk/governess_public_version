
class AgeGroup {
    AgeGroup({
        this.ageGroupId,
        this.name,
    });

    int? ageGroupId;
    String? name;

    factory AgeGroup.fromJson(Map<String, dynamic> json) => AgeGroup(
        ageGroupId: json["ageGroupId"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "ageGroupId": ageGroupId,
        "name": name,
    };
}
