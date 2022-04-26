import 'package:hive/hive.dart';

part 'pin_hive_model.g.dart';

@HiveType(typeId: 1)
class PinHive extends HiveObject {
  @HiveField(0)
  late String pinUser;

 }
