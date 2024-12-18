import 'package:json_annotation/json_annotation.dart';
import 'package:todo/domain/entities/task.dart';

import 'due_model.dart';

part 'task_model_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskModelResponse extends TaskEntity {
  @JsonKey(name: 'creator_id')
  final String creatorId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'assignee_id')
  final String? assigneeId;
  @JsonKey(name: 'assigner_id')
  final String? assignerId;
  @JsonKey(name: 'comment_count')
  final int commentCount;
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  final String content;
  final String description;
  final DueModel? due;
  final String? duration;
  final String id;
  final List<String> labels;
  final int order;
  final int priority;
  @JsonKey(name: 'project_id')
  final String projectId;
  @JsonKey(name: 'section_id')
  final String? sectionId;
  @JsonKey(name: 'parent_id')
  final String? parentId;
  final String url;

  const TaskModelResponse({
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
  }) : super(
          creatorId: creatorId,
          createdAt: createdAt,
          assigneeId: assigneeId,
          assignerId: assignerId,
          commentCount: commentCount,
          isCompleted: isCompleted,
          content: content,
          description: description,
          due: due,
          duration: duration,
          id: id,
          labels: labels,
          order: order,
          priority: priority,
          projectId: projectId,
          sectionId: sectionId,
          parentId: parentId,
          url: url,
        );

  factory TaskModelResponse.fromJson(Map<String, dynamic> json) {
    print("TaskModelResponse ${json['creator_id']}");
    print("TaskModelResponse ${json['created_at']}");
    print("TaskModelResponse ${json['assignee_id']}");
    print("TaskModelResponse ${json['assigner_id']}");
    print("TaskModelResponse ${json['comment_count']}");
    print("TaskModelResponse ${json['is_completed']}");
    print("TaskModelResponse ${json['description']}");
    print("TaskModelResponse ${json['due']}");
    print("TaskModelResponse ${json['id']}");
    print("TaskModelResponse ${json['order']}");
    print("TaskModelResponse ${json['parent_id']}");
    print("TaskModelResponse ${json['section_id']}");
    print("TaskModelResponse ${json['url']}");
    // print("TaskModelResponse ${DueModel.fromJson(json['due']).}");
    print("TaskModelResponse ${json['creator_id']}");
    print("TaskModelResponse ${json['creator_id']}");

    return TaskModelResponse(
      creatorId: json['creator_id'] as String,
      createdAt: json['created_at'] as String,
      assigneeId: json['assignee_id'] as String?,
      assignerId: json['assigner_id'] as String?,
      commentCount: (json['comment_count'] as num).toInt(),
      isCompleted: json['is_completed'] as bool,
      content: json['content'] as String,
      description: json['description'] as String,
      /*due: json['due'] == null
          ? null
          : DueModel.fromJson(json['due'] as Map<String, dynamic>),*/
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
  }

/*  factory TaskModelResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskModelResponseFromJson(json);*/

  Map<String, dynamic> toJson() => _$TaskModelResponseToJson(this);
}
