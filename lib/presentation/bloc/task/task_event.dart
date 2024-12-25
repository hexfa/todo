import 'package:equatable/equatable.dart';
import 'package:todo/data/models/task_data_request.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class FetchTasksEvent extends TasksEvent {
  final String? projectId;

  const FetchTasksEvent(this.projectId);
}

class DeleteEvent extends TasksEvent {
  final String? projectId;
  final String? taskId;

  const DeleteEvent(this.taskId, this.projectId);
}

class UpdateFetchTasksEvent extends TasksEvent {
  final String? projectId;

  const UpdateFetchTasksEvent(this.projectId);
}

class UpdateTaskEvent extends TasksEvent {
  final String? taskId;
  final TaskDataRequest task;

  const UpdateTaskEvent(this.taskId, this.task);
}
