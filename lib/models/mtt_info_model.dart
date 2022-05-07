
class MttInfo {
    MttInfo({
        this.id,
        this.name,
        this.phoneNumber,
        this.region,
        this.district,
        this.street,
        this.accountNumber,
        this.mfo,
        this.inn,
        this.type,
        this.users,
    });

    int? id;
    String? name;
    String? phoneNumber;
    String? region;
    String? district;
    String? street;
    String? accountNumber;
    String? mfo;
    String? inn;
    dynamic type;
    dynamic users;

    factory MttInfo.fromJson(Map<String, dynamic> json) => MttInfo(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        region: json["region"],
        district: json["district"],
        street: json["street"],
        accountNumber: json["accountNumber"],
        mfo: json["mfo"],
        inn: json["inn"],
        type: json["type"],
        users: json["users"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "region": region,
        "district": district,
        "street": street,
        "accountNumber": accountNumber,
        "mfo": mfo,
        "inn": inn,
        "type": type,
        "users": users,
    };
}
