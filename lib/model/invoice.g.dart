// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final int typeId = 5;

  @override
  Invoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invoice(
      fields[0] as int,
      fields[1] as int,
      fields[4] as DateTime,
      fields[5] as DateTime,
      fields[6] as double,
    )
      ..currentElectricityNumber = fields[2] as int?
      ..currentWaterNumber = fields[3] as int?
      ..amountOwed = fields[7] as double?
      ..activities = (fields[8] as HiveList?)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.newElectricityNumber)
      ..writeByte(1)
      ..write(obj.newWaterNumber)
      ..writeByte(2)
      ..write(obj.currentElectricityNumber)
      ..writeByte(3)
      ..write(obj.currentWaterNumber)
      ..writeByte(4)
      ..write(obj.fromDate)
      ..writeByte(5)
      ..write(obj.toDate)
      ..writeByte(6)
      ..write(obj.amountAlreadyPay)
      ..writeByte(7)
      ..write(obj.amountOwed)
      ..writeByte(8)
      ..write(obj.activities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
