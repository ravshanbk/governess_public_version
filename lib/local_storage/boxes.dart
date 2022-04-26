import 'package:governess/models/hive_models/pin_hive_model.dart';
import 'package:governess/models/hive_models/user_h_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<UserH> getUser() => Hive.box<UserH>("user");
  static Box<PinHive> getPinUser() => Hive.box<PinHive>("pinUser");
  
}