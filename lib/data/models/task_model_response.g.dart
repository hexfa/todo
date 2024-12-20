// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelResponseAdapter extends TypeAdapter<TaskModelResponse> {
  @override
  final int typeId = 1;

  @override
  TaskModelResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModelResponse(
      creatorId: fields[0] as String,
      createdAt: fields[1] as String,
      assigneeId: fields[2] as String?,
      assignerId: fields[3] as String?,
      commentCount: fields[4] as int,
      isCompleted: fields[5] as bool,
      content: fields[6] as String,
      description: fields[7] as String,
      due: fields[8] as DueModel?,
      duration: fields[9] as String?,
      id: fields[10] as String,
      labels: (fields[11] as List).cast<String>(),
      order: fields[12] as int,
      priority: fields[13] as int,
      projectId: fields[14] as String,
      sectionId: fields[15] as String?,
      parentId: fields[16] as String?,
      url: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModelResponse obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.creatorId)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.assigneeId)
      ..writeByte(3)
      ..write(obj.assignerId)
      ..writeByte(4)
      ..write(obj.commentCount)
      ..writeByte(5)
      ..write(obj.isCompleted)
      ..writeByte(6)
      ..write(obj.content)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.due)
      ..writeByte(9)
      ..write(obj.duration)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(11)
      ..write(obj.labels)
      ..writeByte(12)
      ..write(obj.order)
      ..writeByte(13)
      ..write(obj.priority)
      ..writeByte(14)
      ..write(obj.projectId)
      ..writeByte(15)
      ..write(obj.sectionId)
      ..writeByte(16)
      ..write(obj.parentId)
      ..writeByte(17)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModelResponse _$TaskModelResponseFromJson(Map<String, dynamic> json) =>
    TaskModelResponse(
      creatorId: json['creator_id'] as String,
      createdAt: json['created_at'] as String,
      assigneeId: json['assignee_id'] as String?,
      assignerId: json['assigner_id'] as String?,
      commentCount: (json['comment_count'] as num).toInt(),
      isCompleted: json['is_completed'] as bool,
      content: json['content'] as String,
      description: json['description'] as String,
      due: json['due'] == null
          ? null
          : DueModel.fromJson(json['due'] as Map<String, dynamic>),
      duration: json['duration'] as String?,
      id: json['id'] as String,
      labels:
          (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
      order: (json['order'] as num).toInt(),
      priority: (json['priority'] as num).toInt(),
      projectId: json['project_id'] as String,
      sectionId: json['section_id'] as String?,
      parentId: json['parent_id'] as String?,
      url: json['url'] as String,
    );

Map<String, dynamic> _$TaskModelResponseToJson(TaskModelResponse instance) =>
    <String, dynamic>{
      'creator_id': instance.creatorId,
      'created_at': instance.createdAt,
      'assignee_id': instance.assigneeId,
      'assigner_id': instance.assignerId,
      'comment_count': instance.commentCount,
      'is_completed': instance.isCompleted,
      'content': instance.content,
      'description': instance.description,
      'due': instance.due?.toJson(),
      'duration': instance.duration,
      'id': instance.id,
      'labels': instance.labels,
      'order': instance.order,
      'priority': instance.priority,
      'project_id': instance.projectId,
      'section_id': instance.sectionId,
      'parent_id': instance.parentId,
      'url': instance.url,
    };
