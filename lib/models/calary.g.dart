// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalaryModelAdapter extends TypeAdapter<CalaryModel> {
  @override
  final int typeId = 1;

  @override
  CalaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalaryModel(
      calaryAmount: fields[2] as double,
      date: fields[3] as DateTime,
      foodName: fields[1] as String,
      category: fields[4] as Category,
      carbs: fields[5] as double,
      protien: fields[6] as double,
      fats: fields[7] as double,
      sugar: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CalaryModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.foodName)
      ..writeByte(2)
      ..write(obj.calaryAmount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.carbs)
      ..writeByte(6)
      ..write(obj.protien)
      ..writeByte(7)
      ..write(obj.fats)
      ..writeByte(8)
      ..write(obj.sugar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
