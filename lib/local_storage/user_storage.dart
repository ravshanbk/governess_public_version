import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/hive_models/user_h_model.dart';

class UserHive {
  addUser(
    { int? id,
    String? role,
     String? token,
    bool? success,
    String? username,
     String? surname,
     String? name,
    String? fatherName,
  }) {
    final user = UserH()
      ..id = id!
      ..role = role!
      ..token = token!
      ..success = success!
      ..username = username!
      ..surname = surname!
      ..name = name!
      ..fatherName = fatherName??"null";

    final box = Boxes.getUser();

    box.putAt(0,user);
  }
}
