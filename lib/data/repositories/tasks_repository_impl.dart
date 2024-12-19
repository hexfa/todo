import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/tasks_remote_datasource.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource remoteDataSource;

  TasksRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks(String? projectId) async {
    try {
      final taskModels = await remoteDataSource.getTasks(projectId);
      final tasks = taskModels.map((model) => model).toList();
      return Right(tasks);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'Unexpected Error'));
    }
  }
}
