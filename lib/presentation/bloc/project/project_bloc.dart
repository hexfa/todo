import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/usecases/delete_usease.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';
import 'package:todo/presentation/bloc/project/project_event.dart';
import 'package:todo/presentation/bloc/project/project_state.dart';

import '../../../domain/usecases/create_project_usecase.dart';
import '../../../domain/usecases/no_param.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjectsUseCase getProjectsUseCase;
  final CreateProjectUseCase createProjectUseCase;
  final DeleteProjectUseCase deleteUseCase;

  ProjectsBloc({
    required this.getProjectsUseCase,
    required this.createProjectUseCase,
    required this.deleteUseCase,
  }) : super(ProjectsInitial()) {
    on<FetchProjectsEvent>((event, emit) async {
      emit(ProjectsLoading());
      final result = await getProjectsUseCase(NoParams());
      result.fold(
        (failure) => emit(ProjectsError('Failed to load projects')),
        (projects) => emit(ProjectsLoaded(projects)),
      );
    });
    on<DeleteProjectEvent>((event, emit) async {
      emit(ProjectsLoading());
      final result = await deleteUseCase(event.id);
      result.fold(
        (failure) => emit(ProjectsError('Failed to delete project')),
        (projects) => emit(DeleteProjectState()),
      );
    });

    on<CreateProjectEvent>((event, emit) async {
      emit(ProjectsLoading());
      final either = await createProjectUseCase(event.name);
      either.fold(
        (failure) {
          if (failure.message.contains('403')) {
            emit(ProjectsError(
                'Maximum number of projects per user limit reached'));
          } else {
            emit(ProjectsError(failure.message));
          }
        },
        (project) {
          emit(ProjectCreateSuccess(project));
          add(GetProjectsEvent());
        },
      );
    });
  }
}
