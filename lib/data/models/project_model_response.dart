import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo/domain/entities/project.dart';

part 'project_model_response.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class ProjectModelResponse extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @JsonKey(name: 'comment_count')
  @HiveField(2)
  final int commentCount;

  @HiveField(3)
  final int order;

  @HiveField(4)
  final String color;

  @JsonKey(name: 'is_shared')
  @HiveField(5)
  final bool isShared;

  @JsonKey(name: 'is_favorite')
  @HiveField(6)
  final bool isFavorite;

  @JsonKey(name: 'parent_id')
  @HiveField(7)
  final String? parentId;

  @JsonKey(name: 'is_inbox_project')
  @HiveField(8)
  final bool isInboxProject;

  @JsonKey(name: 'is_team_inbox')
  @HiveField(9)
  final bool isTeamInbox;

  @JsonKey(name: 'view_style')
  @HiveField(10)
  final String viewStyle;

  @HiveField(11)
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

  // JSON Serialization
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
