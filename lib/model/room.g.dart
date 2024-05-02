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
      fields[0] as DateTime,
      fields[1] as int,
      fields[2] as String,
      fields[3] == null ? 0.0 : fields[3] as double,
      fields[4] == null ? 0.0 : fields[4] as double,
      fields[5] as int,
      fields[6] as int,
      fields[8] == null ? false : fields[8] as bool,
    )..invoices = (fields[7] as HiveList).castHiveList();
  }

  @override
  void write(BinaryWriter writer, Room obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.rentDueDate)
      ..writeByte(1)
      ..write(obj.roomNumber)
      ..writeByte(2)
      ..write(obj.roomRenterName)
      ..writeByte(3)
      ..write(obj.amountOfRoom)
      ..writeByte(4)
      ..write(obj.totalAmountOwed)
      ..writeByte(5)
      ..write(obj.currentElectricityNumber)
      ..writeByte(6)
      ..write(obj.currentWaterNumber)
      ..writeByte(7)
      ..write(obj.invoices)
      ..writeByte(8)
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
