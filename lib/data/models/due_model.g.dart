// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DueModelAdapter extends TypeAdapter<DueModel> {
  @override
  final int typeId = 4;

  @override
  DueModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DueModel(
      date: fields[0] as String?,
      isRecurring: fields[1] as bool?,
      datetime: fields[2] as String?,
      string: fields[3] as String?,
      timezone: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DueModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.isRecurring)
      ..writeByte(2)
      ..write(obj.datetime)
      ..writeByte(3)
      ..write(obj.string)
      ..writeByte(4)
      ..write(obj.timezone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DueModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DueModel _$DueModelFromJson(Map<String, dynamic> json) => DueModel(
      date: json['date'] as String?,
      isRecurring: json['is_recurring'] as bool?,
      datetime: json['datetime'] as String?,
      string: json['string'] as String?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$DueModelToJson(DueModel instance) => <String, dynamic>{
      'date': instance.date,
      'is_recurring': instance.isRecurring,
      'datetime': instance.datetime,
      'string': instance.string,
      'timezone': instance.timezone,
    };
