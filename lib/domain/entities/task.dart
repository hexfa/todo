import 'package:equatable/equatable.dart';

import 'due.dart';

class TaskEntity extends Equatable {
  final String creatorId;
  final String createdAt;
  final String? assigneeId;
  final String? assignerId;
  final int commentCount;
  final bool isCompleted;
  final String content;
  final String description;
  final Due? due;
  final String? duration;
  final String id;
  final List<String> labels;
  final int order;
  final int priority;
  final String projectId;
  final String? sectionId;
  final String? parentId;
  final String url;

  const TaskEntity({
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

  @override
  List<Object?> get props => [
        creatorId,
        createdAt,
        assigneeId,
        assignerId,
        commentCount,
        isCompleted,
        content,
        description,
        due,
        duration,
        id,
        labels,
        order,
        priority,
        projectId,
        sectionId,
        parentId,
        url,
      ];
}
