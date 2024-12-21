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

  // final String? durationChange;
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
    required this.id,
    this.assigneeId,
    this.assignerId,
    required this.content,
    required this.description,
    required this.due,
    // this.durationChange,
    required this.labels,
    required this.order,
    required this.priority,
    required this.projectId,
    this.sectionId,
    this.parentId,
    required this.url,
    this.commentCount = 0,
    this.isCompleted = false,
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
        // durationChange,
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
