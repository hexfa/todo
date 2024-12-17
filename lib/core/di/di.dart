import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasources/projects_remote_datasource.dart';
import '../../data/repositories/projects_repository_impl.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../presentation/bloc/project_bloc.dart';
import '../../services/api/dio_client.dart';
import '../../services/api/project_service.dart';

final getIt = GetIt.instance;

void setupLocator(String token) {
  final dio = createDio(token);
  getIt.registerLazySingleton<Dio>(() => dio);

  final projectService = ProjectService(dio);
  getIt.registerLazySingleton<ProjectService>(() => projectService);

  getIt.registerLazySingleton<ProjectsRemoteDataSource>(
      () => ProjectsRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<ProjectsRepositoryImpl>(
      () => ProjectsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<GetProjects>(
      () => GetProjects(getIt<ProjectsRepositoryImpl>()));
  getIt.registerFactory<ProjectsBloc>(() => ProjectsBloc(getIt<GetProjects>()));
}
