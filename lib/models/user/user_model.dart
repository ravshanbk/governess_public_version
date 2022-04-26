class User {
  int? id;
  String? role;
  String? token;
  bool? success;
  String? username;
  String? surname;
  String? name;
  String? fatherName;

  User(
      {this.id,
      this.role,
      this.token,
      this.success,
      this.username,
      this.surname,
      this.name,
      this.fatherName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    token = json['token'];
    success = json['success'];
    username = json['username'];
    surname = json['surname'];
    name = json['name'];
    fatherName = json['fatherName'];
  }

  
}
