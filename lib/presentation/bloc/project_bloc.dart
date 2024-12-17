// lib/features/projects/presentation/bloc/projects_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';
import 'package:todo/presentation/bloc/project_event.dart';
import 'package:todo/presentation/bloc/project_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjects getProjectsUseCase;

  ProjectsBloc(this.getProjectsUseCase) : super(ProjectsInitial()) {
    on<FetchProjectsEvent>((event, emit) async {
      emit(ProjectsLoading());
      print("ProjectsLoading");
      final result = await getProjectsUseCase(NoParams());
      print("result$result");
      result.fold(
        (failure) => emit(ProjectsError('Failed to load projects')),
        (projects) => emit(ProjectsLoaded(projects)),
      );
    });
  }
}
