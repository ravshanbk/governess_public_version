// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_h_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHAdapter extends TypeAdapter<UserH> {
  @override
  final int typeId = 0;

  @override
  UserH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserH()
      ..token = fields[0] as String
      ..id = fields[1] as int
      ..role = fields[2] as String
      ..success = fields[3] as bool
      ..username = fields[4] as String
      ..surname = fields[5] as String
      ..name = fields[6] as String
      ..fatherName = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, UserH obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.success)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.surname)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.fatherName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
