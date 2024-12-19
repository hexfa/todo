import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/tasks_remote_datasource.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';

import '../models/task_data_request.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource remoteDataSource;

  TasksRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final taskModels = await remoteDataSource.getTasks();
      final tasks = taskModels.map((model) => model).toList();
      return Right(tasks);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'Unexpected Error'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> createTask(
      TaskDataRequest taskData) async {
    try {
      final taskModel = await remoteDataSource.createTask(taskData);
      final task = taskModel; // Map to domain entity if necessary
      return Right(task);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask(String id) async {
    try {
      final result = await remoteDataSource.deleteTask(id);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> closeTask(String id) async {
    try {
      final result = await remoteDataSource.closeTask(id);
      return Right(result);
    }on ServerFailure catch (e) {
  return Left(ServerFailure(message: e.message));
  } catch (e) {
  return const Left(ServerFailure(message: 'Unexpected Error'));
  }
  }
}
