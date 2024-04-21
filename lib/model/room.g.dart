// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoomAdapter extends TypeAdapter<Room> {
  @override
  final int typeId = 2;

  @override
  Room read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Room(
      fields[1] as DateTime,
      fields[2] as int,
      fields[3] as House,
      fields[4] as int,
      fields[5] == null ? 0.0 : fields[5] as double,
      fields[6] as double,
      fields[7] as int,
      fields[8] as int,
      (fields[9] as List).cast<int>(),
      (fields[10] as List).cast<int>(),
      fields[11] == null ? false : fields[11] as bool,
    )..id = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, Room obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.roomNumber)
      ..writeByte(3)
      ..write(obj.house)
      ..writeByte(4)
      ..write(obj.roomRenterId)
      ..writeByte(5)
      ..write(obj.amountOfRoom)
      ..writeByte(6)
      ..write(obj.totalAmountOwed)
      ..writeByte(7)
      ..write(obj.currentElectricityNumber)
      ..writeByte(8)
      ..write(obj.currentWaterNumber)
      ..writeByte(9)
      ..write(obj.roomActivitieIds)
      ..writeByte(10)
      ..write(obj.invoiceIds)
      ..writeByte(11)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
