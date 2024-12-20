// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as String,
      content: json['content'] as String,
      postedAt: json['posted_at'] as String,
      projectId: json['project_id'] as String?,
      taskId: json['task_id'] as String?,
      attachment:
          AttachmentModel.fromJson(json['attachment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'posted_at': instance.postedAt,
      'project_id': instance.projectId,
      'task_id': instance.taskId,
      'attachment': instance.attachment,
    };
