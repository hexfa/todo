part of 'create_task_bloc.dart';

abstract class CreateTaskState extends StateBase {}

final class CreateTaskInitial extends CreateTaskState {
  @override
  List<Object> get props => [];
}

final class CreateTaskSuccessState extends CreateTaskState {
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
