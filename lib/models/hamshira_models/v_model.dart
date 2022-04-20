class AgeGroupIdAndNumber {
  int? ageGroupId;
  int? number;

  AgeGroupIdAndNumber({this.ageGroupId, this.number});

  AgeGroupIdAndNumber.fromJson(Map<String, dynamic> json) {
    ageGroupId = json['ageGroupId'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['ageGroupId'] = ageGroupId;
    data['number'] = number;
    return data;
  }
}
