import 'package:todo/presentation/bloc/base/event_base.dart';

abstract class UpdateTaskEvent extends EventBase {
  @override
  List<Object> get props => [];
}

class TaskLoading extends UpdateTaskEvent {}

class ChangeTimer extends UpdateTaskEvent {
  final String id;
  final String projectId;
  final String content;
  final String description;
  final int priority;
  final String deadLine;
  final String startTimer;
  final int duration;

  ChangeTimer(
      {required this.id,
      required this.projectId,
      required this.content,
      required this.description,
      required this.priority,
      required this.deadLine,
      required this.startTimer,
      required this.duration});

  @override
  List<Object> get props => [
        projectId,
        content,
        description,
        priority,
        deadLine,
        startTimer,
        duration
      ];
}

class UpdateTimer extends UpdateTaskEvent {}

class ConfirmUpdateTask extends UpdateTaskEvent {
  final String id;
  final String projectId;
  final String content;
  final String description;
  final int priority;
  final String deadLine;
  final String startTimer;
  final int duration;

  ConfirmUpdateTask(
      {required this.id,
      required this.projectId,
      required this.content,
      required this.description,
      required this.priority,
      required this.deadLine,
      required this.startTimer,
      required this.duration});

  @override
  List<Object> get props => [
        projectId,
        content,
        description,
        priority,
        deadLine,
        startTimer,
        duration
      ];
}

class CreateCommentEvent extends UpdateTaskEvent {
  final String comment;

  CreateCommentEvent(this.comment);

  @override
  List<Object> get props => [comment];
}

class FetchTask extends UpdateTaskEvent {
  final String taskId;

  FetchTask({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
