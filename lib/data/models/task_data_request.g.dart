// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDataRequest _$TaskDataRequestFromJson(Map<String, dynamic> json) =>
    TaskDataRequest(
      content: json['content'] as String?,
      description: json['description'] as String?,
      deadLine: json['due_date'] as String?,
      priority: json['priority'] as String?,
      projectId: json['project_id'] as String?,
    );

Map<String, dynamic> _$TaskDataRequestToJson(TaskDataRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'description': instance.description,
      'due_date': instance.deadLine,
      'priority': instance.priority,
      'project_id': instance.projectId,
    };
