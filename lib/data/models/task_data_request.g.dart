// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDataRequest _$TaskDataRequestFromJson(Map<String, dynamic> json) =>
    TaskDataRequest(
      content: json['content'] as String?,
      description: json['description'] as String?,
      startDate: json['due_datetime'] as String?,
      deadLine: json['due_date'] as String?,
      priority: (json['priority'] as num?)?.toInt(),
      projectId: json['project_id'] as String?,
      startTimer: json['due_string'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      durationUnit: json['duration_unit'] as String?,
    );

Map<String, dynamic> _$TaskDataRequestToJson(TaskDataRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'description': instance.description,
      'due_datetime': instance.startDate,
      'due_date': instance.deadLine,
      'priority': instance.priority,
      'project_id': instance.projectId,
      'due_string': instance.startTimer,
      'duration': instance.duration,
      'duration_unit': instance.durationUnit,
    };
