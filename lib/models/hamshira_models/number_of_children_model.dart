class NumberOfChildren {
  District? district;
  List<PerDayList>? perDayList;

  NumberOfChildren({this.district, this.perDayList});

  NumberOfChildren.fromJson(Map<String, dynamic> json) {
    district = json['district'] != null
        ?  District.fromJson(json['district'])
        : null;
    if (json['perDayList'] != null) {
      perDayList = <PerDayList>[];
      json['perDayList'].forEach((v) {
        perDayList!.add( PerDayList.fromJson(v));
      });
    }
  }

 
}

class District {
  int? id;
  String? name;

  District({this.id, this.name});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

 
}

class PerDayList {
  int? id;
  int? createDate;
  int? updateDate;
  int? createdBy;
  int? updateBy;
  String? status;
  List<NumberOfChildrenDTOList>? numberOfChildrenDTOList;
  int? kindergartenId;
  String? kindergartenName;

  PerDayList(
      {this.id,
      this.createDate,
      this.updateDate,
      this.createdBy,
      this.updateBy,
      this.status,
      this.numberOfChildrenDTOList,
      this.kindergartenId,
      this.kindergartenName});

  PerDayList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    createdBy = json['createdBy'];
    updateBy = json['updateBy'];
    status = json['status'];
    if (json['numberOfChildrenDTOList'] != null) {
      numberOfChildrenDTOList = <NumberOfChildrenDTOList>[];
      json['numberOfChildrenDTOList'].forEach((v) {
        numberOfChildrenDTOList!.add(NumberOfChildrenDTOList.fromJson(v));
      });
    }
    kindergartenId = json['kindergartenId'];
    kindergartenName = json['kindergartenName'];
  }

}

class NumberOfChildrenDTOList {
  int? id;
  int? number;
  int? createDate;
  int? updateDate;
  int? ageGroupId;
  String? ageGroupName;

  NumberOfChildrenDTOList(
      {this.id,
      this.number,
      this.createDate,
      this.updateDate,
      this.ageGroupId,
      this.ageGroupName});

  NumberOfChildrenDTOList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    ageGroupId = json['ageGroupId'];
    ageGroupName = json['ageGroupName'];
  }

 
}
