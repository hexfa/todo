import 'package:equatable/equatable.dart';

class TaskDataEntityRequest extends Equatable {
  final String? content;
  final String? description;
  final String? startDate;
  final String? deadLine;
  final int? priority;
  final String? projectId;

  const TaskDataEntityRequest(
      {required this.content,
      required this.description,
      required this.startDate,
      required this.deadLine,
      required this.priority,
      required this.projectId});

  @override
  List<Object?> get props =>
      [content, description, deadLine, priority, projectId];
}
