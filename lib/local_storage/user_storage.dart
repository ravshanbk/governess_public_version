import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/hive_models/pin_hive_model.dart';
import 'package:governess/models/hive_models/user_h_model.dart';

class UserHive {
  addUser({
    int? id,
    String? role,
    String? token,
    bool? success,
    String? username,
    String? surname,
    String? name,
    String? fatherName,
  }) async{
    final user = UserH()
      ..id = id!
      ..role = role!
      ..token = token!
      ..success = success!
      ..username = username!
      ..surname = surname!
      ..name = name!
      ..fatherName = fatherName ?? "null";

    final box =  Boxes.getUser();

    if (box.isEmpty) {
     await box.add(user);
    } else {
    await  box.putAt(0, user);
    }
  }

  logOutUser()async {
    final pinBox = Boxes.getPinUser();
   await pinBox.clear();
    final box = Boxes.getUser();
   await box.clear();
  }

  pinSave(String pin) async{
    final pinUser = PinHive()..pinUser = pin;

    final box = Boxes.getPinUser();

    if (box.isEmpty) {
   await   box.add(pinUser);
    } else {
   await   box.putAt(0, pinUser);
    }
  }
}
