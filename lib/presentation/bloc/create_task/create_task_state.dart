part of 'create_task_bloc.dart';

abstract class CreateTaskState extends StateBase {}

final class AddTaskInitial extends CreateTaskState {
  @override
  List<Object> get props => [];
}

final class InitialDataState extends CreateTaskState {
  final List<String> stateList;

  final List<Project> projectList;
  final List<String> pointList;
  final List<int> priorityList;

  InitialDataState(
      this.stateList, this.projectList, this.pointList, this.priorityList);

  @override
  List<Object> get props => [stateList, projectList, pointList, priorityList];
}

final class AddSuccessState extends CreateTaskState {
  @override
  List<Object> get props => [];
}
