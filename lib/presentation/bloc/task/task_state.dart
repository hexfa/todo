import 'package:equatable/equatable.dart';
import 'package:todo/domain/entities/section.dart';
import 'package:todo/domain/entities/task.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final List<TaskEntity> tasks;
  final List<Section> sections;

  const TasksLoaded(this.tasks, this.sections);

  @override
  List<Object?> get props => [tasks];
}

class TasksError extends TasksState {
  final String message;

  const TasksError(this.message);

  @override
  List<Object?> get props => [message];
}
