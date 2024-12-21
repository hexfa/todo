// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DurationModelAdapter extends TypeAdapter<DurationModel> {
  @override
  final int typeId = 3;

  @override
  DurationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DurationModel(
      amount: fields[0] as int,
      unit: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DurationModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DurationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DurationModel _$DurationModelFromJson(Map<String, dynamic> json) =>
    DurationModel(
      amount: (json['amount'] as num).toInt(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$DurationModelToJson(DurationModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'unit': instance.unit,
    };
