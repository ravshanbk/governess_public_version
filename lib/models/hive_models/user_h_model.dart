import 'package:hive/hive.dart';
part 'user_h_model.g.dart';

@HiveType(typeId: 0)
class UserH extends HiveObject {
  @HiveField(0)
  late String token;

  @HiveField(1)
  late int id;

  @HiveField(2)
  late String role;

  @HiveField(3)
  late bool success;

  @HiveField(4)
  late String username;

  @HiveField(5)
  late String surname;

  @HiveField(6)
  late String name;

  @HiveField(7)
  String? fatherName;
}
