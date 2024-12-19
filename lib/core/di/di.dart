import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/data/datasources/projects_remote_datasource.dart';
import 'package:todo/data/datasources/tasks_remote_datasource.dart';
import 'package:todo/data/datasources/tasks_remote_datasource_impl.dart';
import 'package:todo/data/repositories/projects_repository_impl.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/domain/repositories/projects_repository.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';
import 'package:todo/domain/usecases/create_project_usecase.dart';
import 'package:todo/domain/usecases/delete_task_usecase.dart';
import 'package:todo/domain/usecases/delete_usease.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';
import 'package:todo/domain/usecases/get_tasks_usecase.dart';
import 'package:todo/domain/usecases/update_task_usecase.dart';
import 'package:todo/presentation/bloc/project/project_bloc.dart';
import 'package:todo/presentation/bloc/task/task_bloc.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'package:todo/services/api/dio_client.dart';
import 'package:todo/services/api/project_service.dart';


final getIt = GetIt.instance;

Future<void> setupLocator(String token) async {
  final dio = createDio(token);
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<Storage>(() => Storage());

  getIt.registerLazySingleton<AppRouter>(
          () => AppRouter(storage: getIt<Storage>()));

  final projectService = ProjectService(dio);
  getIt.registerLazySingleton<ProjectService>(() => projectService);

  // Register data sources
  getIt.registerLazySingleton<ProjectsRemoteDataSource>(
          () => ProjectsRemoteDataSourceImpl(getIt()));

  getIt.registerLazySingleton<TasksRemoteDataSource>(
    () => TasksRemoteDataSourceImpl(
      service: getIt<ProjectService>(),
    ),
  );

  // Register repositories
  getIt.registerLazySingleton<ProjectsRepository>(
          () => ProjectsRepositoryImpl( remoteDataSource: getIt()));

  getIt.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(remoteDataSource: getIt<TasksRemoteDataSource>()),
  );

  // Register use cases
  getIt.registerLazySingleton<GetProjectsUseCase>(
          () => GetProjectsUseCase(getIt<ProjectsRepository>()));

  getIt.registerLazySingleton<UpdateTaskUseCase>(
      () => UpdateTaskUseCase(getIt<TasksRepository>()));

  getIt.registerLazySingleton<CreateProjectUseCase>(
        () => CreateProjectUseCase(getIt<ProjectsRepository>()),
  );

  getIt.registerLazySingleton<DeleteTaskUseCase>(
    () => DeleteTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<GetTasksUseCase>(
    () => GetTasksUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<DeleteProjectUseCase>(
        () => DeleteProjectUseCase(getIt<ProjectsRepository>()),
  );

  // Register blocs
  getIt.registerFactory<ProjectsBloc>(
        () => ProjectsBloc(
      createProjectUseCase: getIt<CreateProjectUseCase>(),
      getProjectsUseCase: getIt<GetProjectsUseCase>(),
      deleteUseCase: getIt<DeleteProjectUseCase>(),
    ),
  );

  getIt.registerFactory<TasksBloc>(
    () => TasksBloc(
        getTasksUseCase: getIt<GetTasksUseCase>(),
        updateTaskUseCase: getIt<UpdateTaskUseCase>(),
        deleteTaskUseCase: getIt<DeleteTaskUseCase>()),
  );
}
