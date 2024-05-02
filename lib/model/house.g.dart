// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseAdapter extends TypeAdapter<House> {
  @override
  final int typeId = 1;

  @override
  House read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return House(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] == null ? 3500 : fields[3] as int,
      fields[4] == null ? 17000 : fields[4] as int,
    )..rooms = (fields[5] as HiveList).castHiveList();
  }

  @override
  void write(BinaryWriter writer, House obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.nameOwner)
      ..writeByte(2)
      ..write(obj.availableRooms)
      ..writeByte(3)
      ..write(obj.electricityPrice)
      ..writeByte(4)
      ..write(obj.waterPrice)
      ..writeByte(5)
      ..write(obj.rooms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
