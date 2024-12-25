import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/presentation/bloc/base/event_base.dart';

abstract class UpdateTaskEvent extends EventBase {
  @override
  List<Object> get props => [];
}

class TaskLoading extends UpdateTaskEvent {}

class ChangeTimer extends UpdateTaskEvent {
  final String id;
  final TaskDataRequest task;

  ChangeTimer({required this.id, required this.task});

  @override
  List<Object> get props => [id, task];
}

class UpdateTimer extends UpdateTaskEvent {}

class ConfirmUpdateTask extends UpdateTaskEvent {
  final String id;
  final TaskDataRequest task;

  ConfirmUpdateTask({required this.id, required this.task});

  @override
  List<Object> get props => [id, task];
}

class FetchTask extends UpdateTaskEvent {
  final String taskId;

  FetchTask({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
