import 'package:equatable/equatable.dart';

abstract class ProjectsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProjectsEvent extends ProjectsEvent {}

class CreateProjectEvent extends ProjectsEvent {
  final String name;

  CreateProjectEvent(this.name);
}

class GetProjectsEvent extends ProjectsEvent {}
