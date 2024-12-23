part of 'create_task_bloc.dart';

abstract class CreateTaskState extends StateBase {}

final class AddTaskInitial extends CreateTaskState {
  @override
  List<Object> get props => [];
}

final class InitialDataState extends CreateTaskState {
  final List<Project> projectList;

  InitialDataState(this.projectList);

  @override
  List<Object> get props => [projectList];
}

final class AddSuccessState extends CreateTaskState {
  @override
  List<Object> get props => [];
}

final class CreateTaskLoadingState extends CreateTaskState {
  @override
  List<Object> get props => [];
}

final class CreateTaskFailedState extends CreateTaskState {
  final String message;

  CreateTaskFailedState(this.message);

  @override
  List<Object> get props => [message];
}
