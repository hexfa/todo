import 'package:equatable/equatable.dart';

import 'due.dart';

class TaskEntity extends Equatable {
  final String creatorId;
  final String createdAt;
  final String? assigneeId;
  final String? assignerId;
  final int commentCount;
  final bool isCompleted;
  final String title;
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
  final String state;
  final DateTime createDate = DateTime.now();
  final DateTime? startDate;
  final DateTime? endDate;
  bool isRunning;
  int durationWork;

  const TaskEntity({
    required this.creatorId,
    required this.createdAt,
    this.assigneeId,
    this.assignerId,
    required this.commentCount,
    required this.isCompleted,
    required this.title,
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
    required this.state,
    required this.startDate,
    required this.endDate,
  });

  String get formattedTime {
    final hours = (durationWork ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((durationWork % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (durationWork % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

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
