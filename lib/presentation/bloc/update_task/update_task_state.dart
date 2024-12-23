import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/presentation/bloc/base/state_base.dart';

abstract class UpdateTaskState extends StateBase {
  @override
  List<Object> get props => [];
}

class TaskInitializeState extends UpdateTaskState {}

class UpdateTaskLoadingState extends UpdateTaskState {}

class UpdateTimerFailedState extends UpdateTaskState {}

class UpdateTaskErrorState extends UpdateTaskState {
  final String message;

  UpdateTaskErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ConfirmUpdateTaskState extends UpdateTaskState {}

class UpdateTask extends UpdateTaskState {
  final TaskModelResponse task;
  final DateTime timestamp;

  UpdateTask(this.task) : timestamp = DateTime.now();

  @override
  List<Object> get props => [task, timestamp];
}


class TaskLoadedState extends UpdateTaskState {
  final TaskModelResponse task;

  TaskLoadedState({required this.task});

  @override
  List<Object> get props => [task];
}
