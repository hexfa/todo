// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDataRequest _$TaskDataRequestFromJson(Map<String, dynamic> json) =>
    TaskDataRequest(
      content: json['content'] as String,
      dueString: json['due_string'] as String,
      dueLang: json['due_lang'] as String,
      priority: json['priority'] as String,
    );

Map<String, dynamic> _$TaskDataRequestToJson(TaskDataRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'due_string': instance.dueString,
      'due_lang': instance.dueLang,
      'priority': instance.priority,
    };
