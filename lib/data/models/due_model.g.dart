// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DueModel _$DueModelFromJson(Map<String, dynamic> json) => DueModel(
      date: json['date'] as String,
      isRrecurring: json['is_recurring'] as bool,
      datetime: json['datetime'] as String,
      string: json['string'] as String,
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$DueModelToJson(DueModel instance) => <String, dynamic>{
      'date': instance.date,
      'is_recurring': instance.isRrecurring,
      'datetime': instance.datetime,
      'string': instance.string,
      'timezone': instance.timezone,
    };