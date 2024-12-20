import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/presentation/bloc/base/event_base.dart';

abstract class UpdateTaskEvent extends EventBase {
  @override
  List<Object> get props => [];
}

class TaskLoading extends UpdateTaskEvent {}

class StartTimer extends UpdateTaskEvent {}

class StopTimer extends UpdateTaskEvent {
  final int second;

  StopTimer(this.second);

  @override
  List<Object> get props => [second];
}

class FinishTimer extends UpdateTaskEvent {}

class UpdateTimer extends UpdateTaskEvent {}

class ConfirmUpdateTask extends UpdateTaskEvent {
  final TaskModelResponse task;

  ConfirmUpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class CreateCommentEvent extends UpdateTaskEvent {
  final String comment;

  CreateCommentEvent(this.comment);

  @override
  List<Object> get props => [comment];
}
