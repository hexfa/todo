// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentModelAdapter extends TypeAdapter<CommentModel> {
  @override
  final int typeId = 5;

  @override
  CommentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentModel(
      id: fields[0] as String,
      content: fields[1] as String,
      postedAt: fields[2] as String,
      projectId: fields[3] as String?,
      taskId: fields[4] as String?,
      attachment: fields[5] as AttachmentModel?,
    );
  }

  @override
  void write(BinaryWriter writer, CommentModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.postedAt)
      ..writeByte(3)
      ..write(obj.projectId)
      ..writeByte(4)
      ..write(obj.taskId)
      ..writeByte(5)
      ..write(obj.attachment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as String,
      content: json['content'] as String,
      postedAt: json['posted_at'] as String,
      projectId: json['project_id'] as String?,
      taskId: json['task_id'] as String?,
      attachment: json['attachment'] == null
          ? null
          : AttachmentModel.fromJson(
              json['attachment'] as Map<String, dynamic>),
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
