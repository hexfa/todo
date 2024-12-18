import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/data/datasources/projects_remote_datasource.dart';
import 'package:todo/data/repositories/projects_repository_impl.dart';
import 'package:todo/domain/usecases/delete_usease.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';
import 'package:todo/presentation/bloc/project_bloc.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'package:todo/services/api/dio_client.dart';
import 'package:todo/services/api/project_service.dart';

import '../../domain/usecases/create_project_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupLocator(String token)async {
  final dio = createDio(token);
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<Storage>(() => Storage());

  getIt.registerLazySingleton<AppRouter>(
      () => AppRouter(storage: getIt<Storage>()));

  final projectService = ProjectService(dio);
  getIt.registerLazySingleton<ProjectService>(() => projectService);

  //register data sources
  getIt.registerLazySingleton<ProjectsRemoteDataSource>(
      () => ProjectsRemoteDataSourceImpl(getIt()));

  //register repositories
  getIt.registerLazySingleton<ProjectsRepositoryImpl>(
      () => ProjectsRepositoryImpl(getIt()));

  //register use cases
  getIt.registerLazySingleton<GetProjectsUseCase>(
      () => GetProjectsUseCase(getIt<ProjectsRepositoryImpl>()));

  getIt.registerLazySingleton<CreateProjectUseCase>(
    () => CreateProjectUseCase(getIt<ProjectsRepositoryImpl>()),
  );

  getIt.registerLazySingleton<DeleteUseCase>(
    () => DeleteUseCase(getIt<ProjectsRepositoryImpl>()),
  );

  //register blocs
  getIt.registerFactory<ProjectsBloc>(
    () => ProjectsBloc(
      createProjectUseCase: getIt<CreateProjectUseCase>(),
      getProjectsUseCase: getIt<GetProjectsUseCase>(),
      deleteUseCase:  getIt<DeleteUseCase>(),
    ),
  );
}
