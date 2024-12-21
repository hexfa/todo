import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/data/datasources/comments_remote_datasource.dart';
import 'package:todo/data/datasources/comments_remote_datasource_impl.dart';
import 'package:todo/data/datasources/local/projects_local_datasource.dart';
import 'package:todo/data/datasources/local/sync_local_datasource.dart';
import 'package:todo/data/datasources/local/tasks_local_datasource.dart';
import 'package:todo/data/datasources/remote/projects_remote_datasource.dart';
import 'package:todo/data/datasources/remote/tasks_remote_datasource.dart';
import 'package:todo/data/models/attachment_model.dart';
import 'package:todo/data/models/comment_model.dart';
import 'package:todo/data/models/due_model.dart';
import 'package:todo/data/models/duration_model.dart';
import 'package:todo/data/models/project_model_response.dart';
import 'package:todo/data/models/sync_model.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/data/repositories/projects_repository_impl.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/data/sync_manager.dart';
import 'package:todo/domain/repositories/comments_repository.dart';
import 'package:todo/domain/repositories/projects_repository.dart';
import 'package:todo/domain/usecases/CloseTaskUseCase.dart';
import 'package:todo/domain/usecases/create_task_usecase.dart';
import 'package:todo/domain/usecases/delete_task_usecase.dart';
import 'package:todo/domain/usecases/delete_usease.dart';
import 'package:todo/domain/usecases/get_all_comments_usecase.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';
import 'package:todo/domain/usecases/update_task_usecase.dart';
import 'package:todo/presentation/bloc/project/project_bloc.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'package:todo/services/api/dio_client.dart';
import 'package:todo/services/api/project_service.dart';

import '../../domain/repositories/tasks_repository.dart';
import '../../domain/usecases/create_project_usecase.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import '../../presentation/bloc/task/task_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupLocator(String token) async{
  final dio = createDio(token);
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<Storage>(() => Storage());

  getIt.registerLazySingleton<AppRouter>(
      () => AppRouter(storage: getIt<Storage>()));

  final projectService = ProjectService(dio);
  getIt.registerLazySingleton<ProjectService>(() => projectService);

  // Register Hive Boxes
  final taskBox = await Hive.openBox<TaskModelResponse>('tasks');
  final projectBox = await Hive.openBox<ProjectModelResponse>('projects');
  final syncBox = await Hive.openBox<SyncOperation>('sync');
  final durationBox = await Hive.openBox<DurationModel>('duration');
  final dueBox = await Hive.openBox<DueModel>('due');
  final commentBox = await Hive.openBox<CommentModel>('comment');
  final attachmentBox = await Hive.openBox<AttachmentModel>('attachment');

  getIt.registerSingleton<Box<TaskModelResponse>>(taskBox);
  getIt.registerSingleton<Box<ProjectModelResponse>>(projectBox);
  getIt.registerSingleton<Box<SyncOperation>>(syncBox);
  getIt.registerSingleton<Box<DurationModel>>(durationBox);
  getIt.registerSingleton<Box<DueModel>>(dueBox);
  getIt.registerSingleton<Box<CommentModel>>(commentBox);
  getIt.registerSingleton<Box<AttachmentModel>>(attachmentBox);

  // Register data sources
  //register data sources
  getIt.registerLazySingleton<ProjectsRemoteDataSource>(
      () => ProjectsRemoteDataSourceImpl(getIt()));

  getIt.registerLazySingleton<TasksRemoteDataSource>(
        () => TasksRemoteDataSourceImpl(
      service: getIt<ProjectService>(),
    ),
  );

  // Register Local Data Sources
  getIt.registerLazySingleton<TasksLocalDataSource>(
      () => TasksLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<ProjectsLocalDataSource>(
      () => ProjectsLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<SyncLocalDataSource>(
      () => SyncLocalDataSource(getIt()));



  //register repositories
  getIt.registerLazySingleton<ProjectsRepository>(
          () => ProjectsRepositoryImpl(remoteDataSource:getIt<ProjectsRemoteDataSource>(),
              localDataSource: getIt<ProjectsLocalDataSource>(),
              syncQueue: getIt<SyncLocalDataSource>()));

  getIt.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(
        remoteDataSource: getIt<TasksRemoteDataSource>(),
        localDataSource: getIt(),
        syncQueue: getIt()),
  );
  getIt.registerLazySingleton<CommentsRemoteDataSource>(
        () => CommentsRemoteDataSourceImpl(
      getIt<ProjectService>(),
    ),
  );
  getIt.registerLazySingleton(() => SyncManager(
    syncQueue: getIt<SyncLocalDataSource>(),
    projectsRemoteDataSource: getIt<ProjectsRemoteDataSource>(),
        tasksRemoteDataSource: getIt<TasksRemoteDataSource>(),
        projectsLocalDataSource: getIt(),
        tasksLocalDataSource: getIt(),
      ));

  // Register use cases
  //register use cases
  getIt.registerLazySingleton<GetProjectsUseCase>(
      () => GetProjectsUseCase(getIt<ProjectsRepository>()));

  getIt.registerLazySingleton<CreateProjectUseCase>(
    () => CreateProjectUseCase(getIt<ProjectsRepository>()),
  );

  getIt.registerLazySingleton<GetTasksUseCase>(
        () => GetTasksUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<DeleteProjectUseCase>(
        () => DeleteProjectUseCase(getIt<ProjectsRepository>()),
  );

  getIt.registerLazySingleton<CreateTaskUseCase>(
        () => CreateTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<DeleteTaskUseCase>(
        () => DeleteTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<CloseTaskUseCase>(
        () => CloseTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<UpdateTaskUseCase>(
        () => UpdateTaskUseCase(getIt<TasksRepository>()),
  );

  getIt.registerLazySingleton<GetAllCommentsUseCase>(
        () => GetAllCommentsUseCase(getIt<CommentsRepository>()),
  );
  //register blocs
  getIt.registerFactory<ProjectsBloc>(
    () => ProjectsBloc(
      createProjectUseCase: getIt<CreateProjectUseCase>(),
      getProjectsUseCase: getIt<GetProjectsUseCase>(),
      deleteUseCase:getIt<DeleteProjectUseCase>()
    ),
  );

  getIt.registerFactory<TasksBloc>(
        () => TasksBloc(getTasksUseCase: getIt<GetTasksUseCase>(), updateTaskUseCase: getIt<UpdateTaskUseCase>(), deleteTaskUseCase: getIt<DeleteTaskUseCase>()),
  );
}
