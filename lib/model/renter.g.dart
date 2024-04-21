// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'renter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RenterAdapter extends TypeAdapter<Renter> {
  @override
  final int typeId = 3;

  @override
  Renter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Renter(
      fields[1] as int,
      fields[2] as String,
      fields[3] as DateTime,
      fields[4] as String,
      fields[5] as String,
    )..id = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, Renter obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roomId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.dateOfBirth)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.citizenIdentificationCard);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RenterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
