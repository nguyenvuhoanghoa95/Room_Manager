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
      fields[0] as int?,
      fields[1] as int?,
      fields[4] as DateTime?,
      fields[5] as int?,
      fields[7] as int?,
    )
      ..currentElectricityNumber = fields[2] as int?
      ..currentWaterNumber = fields[3] as int?
      ..note = fields[6] as String?
      ..totalAmount = fields[8] as int?
      ..wifiAmount = fields[9] as int?
      ..electAmount = fields[10] as int?
      ..waterAmount = fields[11] as int?
      ..debitAmount = fields[12] as int?;
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.newElectricityNumber)
      ..writeByte(1)
      ..write(obj.newWaterNumber)
      ..writeByte(2)
      ..write(obj.currentElectricityNumber)
      ..writeByte(3)
      ..write(obj.currentWaterNumber)
      ..writeByte(4)
      ..write(obj.invoiceCreateDate)
      ..writeByte(5)
      ..write(obj.amountAlreadyPay)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.surcharge)
      ..writeByte(8)
      ..write(obj.totalAmount)
      ..writeByte(9)
      ..write(obj.wifiAmount)
      ..writeByte(10)
      ..write(obj.electAmount)
      ..writeByte(11)
      ..write(obj.waterAmount)
      ..writeByte(12)
      ..write(obj.debitAmount);
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
