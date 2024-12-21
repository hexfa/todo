// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectModelResponseAdapter extends TypeAdapter<ProjectModelResponse> {
  @override
  final int typeId = 0;

  @override
  ProjectModelResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectModelResponse(
      id: fields[0] as String,
      name: fields[1] as String,
      commentCount: fields[2] as int,
      order: fields[3] as int,
      color: fields[4] as String,
      isShared: fields[5] as bool,
      isFavorite: fields[6] as bool,
      parentId: fields[7] as String?,
      isInboxProject: fields[8] as bool,
      isTeamInbox: fields[9] as bool,
      viewStyle: fields[10] as String,
      url: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectModelResponse obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.commentCount)
      ..writeByte(3)
      ..write(obj.order)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.isShared)
      ..writeByte(6)
      ..write(obj.isFavorite)
      ..writeByte(7)
      ..write(obj.parentId)
      ..writeByte(8)
      ..write(obj.isInboxProject)
      ..writeByte(9)
      ..write(obj.isTeamInbox)
      ..writeByte(10)
      ..write(obj.viewStyle)
      ..writeByte(11)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectModelResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModelResponse _$ProjectModelResponseFromJson(
        Map<String, dynamic> json) =>
    ProjectModelResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      commentCount: (json['comment_count'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      color: json['color'] as String,
      isShared: json['is_shared'] as bool,
      isFavorite: json['is_favorite'] as bool,
      parentId: json['parent_id'] as String?,
      isInboxProject: json['is_inbox_project'] as bool,
      isTeamInbox: json['is_team_inbox'] as bool,
      viewStyle: json['view_style'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ProjectModelResponseToJson(
        ProjectModelResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'comment_count': instance.commentCount,
      'order': instance.order,
      'color': instance.color,
      'is_shared': instance.isShared,
      'is_favorite': instance.isFavorite,
      'parent_id': instance.parentId,
      'is_inbox_project': instance.isInboxProject,
      'is_team_inbox': instance.isTeamInbox,
      'view_style': instance.viewStyle,
      'url': instance.url,
    };
