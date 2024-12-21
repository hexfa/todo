// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDataRequest _$CommentDataRequestFromJson(Map<String, dynamic> json) =>
    CommentDataRequest(
      content: json['content'] as String?,
      projectId: json['project_id'] as String?,
      taskId: json['task_id'] as String?,
      attachment: json['attachment'] == null
          ? null
          : AttachmentModel.fromJson(
              json['attachment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentDataRequestToJson(CommentDataRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'task_id': instance.taskId,
      'project_id': instance.projectId,
      'attachment': instance.attachment?.toJson(),
    };
