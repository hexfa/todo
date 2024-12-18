import 'package:equatable/equatable.dart';

import '../../../domain/entities/project.dart';

abstract class ProjectsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProjectsInitial extends ProjectsState {}

class ProjectsLoading extends ProjectsState {}
class DeleteProjectState extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;

  ProjectsLoaded(this.projects);

  @override
  List<Object?> get props => [projects];
}

class ProjectsError extends ProjectsState {
  final String message;

  ProjectsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProjectCreateSuccess extends ProjectsState {
  final Project project;

  ProjectCreateSuccess(this.project);
}

