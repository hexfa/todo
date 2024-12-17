import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/project.dart';

part 'project_model_response.g.dart';

@JsonSerializable()
class ProjectModelResponse {
  final String id;
  final String name;
  @JsonKey(name: 'comment_count')
  final int commentCount;
  final int order;
  final String color;
  @JsonKey(name: 'is_shared')
  final bool isShared;
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @JsonKey(name: 'is_inbox_project')
  final bool isInboxProject;
  @JsonKey(name: 'is_team_inbox')
  final bool isTeamInbox;
  @JsonKey(name: 'view_style')
  final String viewStyle;
  final String url;

  ProjectModelResponse({
    required this.id,
    required this.name,
    required this.commentCount,
    required this.order,
    required this.color,
    required this.isShared,
    required this.isFavorite,
    this.parentId,
    required this.isInboxProject,
    required this.isTeamInbox,
    required this.viewStyle,
    required this.url,
  });

  factory ProjectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelResponseToJson(this);

  Project toEntity() => Project(
        id: id,
        name: name,
        commentCount: commentCount,
        order: order,
        color: color,
        isShared: isShared,
        isFavorite: isFavorite,
        parentId: parentId,
        isInboxProject: isInboxProject,
        isTeamInbox: isTeamInbox,
        viewStyle: viewStyle,
        url: url,
      );
}
