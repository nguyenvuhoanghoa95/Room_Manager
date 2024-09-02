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
      fields[8] as int,
      fields[9] as String,
      fields[10] as int,
      fields[3] as int,
    )
      ..invoices = (fields[4] as HiveList).castHiveList()
      ..status = fields[5] == null ? false : fields[5] as bool?
      ..currentElectricityNumber = fields[6] as int
      ..currentWaterNumber = fields[7] as int;
  }

  @override
  void write(BinaryWriter writer, Room obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.rentDueDate)
      ..writeByte(1)
      ..write(obj.roomNumber)
      ..writeByte(2)
      ..write(obj.roomRenterName)
      ..writeByte(3)
      ..write(obj.depositAmount)
      ..writeByte(4)
      ..write(obj.invoices)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.currentElectricityNumber)
      ..writeByte(7)
      ..write(obj.currentWaterNumber)
      ..writeByte(8)
      ..write(obj.datePay)
      ..writeByte(9)
      ..write(obj.telephone)
      ..writeByte(10)
      ..write(obj.numPerson);
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
