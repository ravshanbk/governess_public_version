
class NOCDL {
    NOCDL({
        this.numberOfChildrenDtoList,
    });

    List<NumberOfChildrenDtoListElement>? numberOfChildrenDtoList;

    factory NOCDL.fromJson(Map<String, dynamic> json) => NOCDL(
        numberOfChildrenDtoList: List<NumberOfChildrenDtoListElement>.from(json["numberOfChildrenDTOList"].map((x) => NumberOfChildrenDtoListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "numberOfChildrenDTOList": List<dynamic>.from(numberOfChildrenDtoList!.map((x) => x.toJson())),
    };
}

class NumberOfChildrenDtoListElement {
    NumberOfChildrenDtoListElement({
        this.ageGroupId,
        this.number,
    });

    int? ageGroupId;
    int? number;

    factory NumberOfChildrenDtoListElement.fromJson(Map<String, dynamic> json) => NumberOfChildrenDtoListElement(
        ageGroupId: json["ageGroupId"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "ageGroupId": ageGroupId,
        "number": number,
    };
}
