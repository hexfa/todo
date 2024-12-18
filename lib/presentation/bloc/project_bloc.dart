import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';
import 'package:todo/presentation/bloc/project_event.dart';
import 'package:todo/presentation/bloc/project_state.dart';

import '../../domain/usecases/create_project_usecase.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjectsUseCase getProjectsUseCase;
  final CreateProjectUseCase createProjectUseCase;

  ProjectsBloc(
      {required this.getProjectsUseCase, required this.createProjectUseCase})
      : super(ProjectsInitial()) {
    on<FetchProjectsEvent>((event, emit) async {
      emit(ProjectsLoading());
      final result = await getProjectsUseCase(NoParams());
      result.fold(
        (failure) => emit(ProjectsError('Failed to load projects')),
        (projects) => emit(ProjectsLoaded(projects)),
      );
    });

    on<CreateProjectEvent>((event, emit) async {
      emit(ProjectsLoading());
      final either = await createProjectUseCase(event.name);
      either.fold(
        (failure) => emit(ProjectFailure(failure.message)),
        (project) {
          emit(ProjectCreateSuccess(project));
          add(GetProjectsEvent());
        },
      );
    });
  }
}
