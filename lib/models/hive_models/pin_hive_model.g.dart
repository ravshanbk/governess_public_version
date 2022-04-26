// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PinHiveAdapter extends TypeAdapter<PinHive> {
  @override
  final int typeId = 1;

  @override
  PinHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PinHive()..pinUser = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, PinHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.pinUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PinHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
