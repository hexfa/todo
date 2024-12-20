// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'due_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DueModel _$DueModelFromJson(Map<String, dynamic> json) => DueModel(
      date: json['date'] as String,
      isRrecurring: json['is_recurring'] as bool,
      datetime: json['datetime'] as String,
      startTimer: json['startTimer'] as String,
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$DueModelToJson(DueModel instance) => <String, dynamic>{
      'date': instance.date,
      'is_recurring': instance.isRrecurring,
      'datetime': instance.datetime,
      'startTimer': instance.startTimer,
      'timezone': instance.timezone,
    };
