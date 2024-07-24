// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebitAdapter extends TypeAdapter<Debit> {
  @override
  final int typeId = 4;

  @override
  Debit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Debit(
      fields[0] as int?,
      fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Debit obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
