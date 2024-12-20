import 'package:equatable/equatable.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class FetchTasksEvent extends TasksEvent {
  final String? projectId;
  FetchTasksEvent(this.projectId);
}
class DeleteEvent extends TasksEvent {
  final String? projectId;
  final String? taskId;
  DeleteEvent(this.taskId, this.projectId);
}

class UpdateFetchTasksEvent extends TasksEvent {
  final String? projectId;
  UpdateFetchTasksEvent(this.projectId);
}
class UpdateTaskEvent extends TasksEvent {
  final String? taskId;
  final String? priority;
  final String? projectId;
  UpdateTaskEvent(this.taskId, this.priority, this.projectId);
}
