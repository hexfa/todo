import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo/data/models/duration_model.dart';
import 'package:todo/domain/entities/comment.dart';
import 'package:todo/domain/entities/task.dart';

import 'due_model.dart';

part 'task_model_response.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class TaskModelResponse extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'creator_id')
  final String creatorId;

  @HiveField(1)
  @JsonKey(name: 'created_at')
  final String createdAt;

  @HiveField(2)
  @JsonKey(name: 'assignee_id')
  final String? assigneeId;

  @HiveField(3)
  @JsonKey(name: 'assigner_id')
  final String? assignerId;

  @HiveField(4)
  @JsonKey(name: 'comment_count')
  final int commentCount;

  @HiveField(5)
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  @HiveField(6)
  final String content;

  @HiveField(7)
  final String description;

  @HiveField(8)
  final DueModel? due;

  @HiveField(9)
  final DurationModel? duration;

  @HiveField(10)
  final String id;

  @HiveField(11)
  final List<String> labels;

  @HiveField(12)
  final int order;

  @HiveField(13)
  final int priority;

  @HiveField(14)
  @JsonKey(name: 'project_id')
  final String projectId;

  @HiveField(15)
  @JsonKey(name: 'section_id')
  final String? sectionId;

  @HiveField(16)
  @JsonKey(name: 'parent_id')
  final String? parentId;

  @HiveField(17)
  final String url;
  List<Comment> commentList = [];

  TaskModelResponse({
    required this.creatorId,
    required this.createdAt,
    this.assigneeId,
    this.assignerId,
    required this.commentCount,
    required this.isCompleted,
    required this.content,
    required this.description,
    this.due,
    this.duration,
    required this.id,
    required this.labels,
    required this.order,
    required this.priority,
    required this.projectId,
    this.sectionId,
    this.parentId,
    required this.url,
  });

  factory TaskModelResponse.fromJson(Map<String, dynamic> json) {
    return TaskModelResponse(
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
      duration: json['duration'] == null
          ? null
          : DurationModel.fromJson(json['duration'] as Map<String, dynamic>),
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
  }

  Map<String, dynamic> toJson() => _$TaskModelResponseToJson(this);

  TaskEntity toEntity() {
    return TaskEntity(
      creatorId: creatorId,
      createdAt: createdAt,
      assigneeId: assigneeId,
      assignerId: assignerId,
      commentCount: commentCount,
      isCompleted: isCompleted,
      content: content,
      description: description,
      due: due?.toEntity(),
      // duration: duration?.toEntity(),
      id: id,
      labels: labels,
      order: order,
      priority: priority,
      projectId: projectId,
      sectionId: sectionId,
      parentId: parentId,
      url: url,
    );
  }
}

