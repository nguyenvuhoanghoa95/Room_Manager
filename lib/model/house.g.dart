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
      fields[4] == null ? 100000 : fields[4] as int,
      fields[6] as bool?,
    )
      ..rooms = (fields[5] as HiveList).castHiveList()
      ..expenses = (fields[7] as HiveList).castHiveList()
      ..serviceAmount = fields[8] == null ? 100000 : fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, House obj) {
    writer
      ..writeByte(9)
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
      ..write(obj.rooms)
      ..writeByte(6)
      ..write(obj.isWaterPerPerson)
      ..writeByte(7)
      ..write(obj.expenses)
      ..writeByte(8)
      ..write(obj.serviceAmount);
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
