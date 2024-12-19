import 'package:equatable/equatable.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class FetchTasksEvent extends TasksEvent {
  final String? projectId;
  FetchTasksEvent(this.projectId);
}
