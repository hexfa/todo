// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model_response.dart';

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
