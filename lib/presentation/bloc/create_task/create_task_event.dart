part of 'create_task_bloc.dart';

abstract class CreateTaskEvent extends EventBase {}

class ConfirmCreateTaskEvent extends CreateTaskEvent {
  final TaskDataEntityRequest task;

  ConfirmCreateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}
