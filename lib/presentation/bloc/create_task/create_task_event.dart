part of 'create_task_bloc.dart';

abstract class CreateTaskEvent extends EventBase {}

class InitialDataEvent extends CreateTaskEvent {
  @override
  List<Object> get props => [];
}

class FetchProject extends CreateTaskEvent {
  @override
  List<Object> get props => [];
}

class AddEvent extends CreateTaskEvent {
  final TaskEntity task;

  AddEvent(this.task);

  @override
  List<Object> get props => [task];
}
