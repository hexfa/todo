import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/task.dart';

import '../../data/models/task_data_request.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks(String? projectId);

  Future<Either<Failure, TaskEntity>> getTask(String? taskId);

  Future<Either<Failure, TaskEntity>> createTask(TaskDataRequest taskData);

  Future<Either<Failure, bool>> deleteTask(String id);

  Future<Either<Failure, bool>> closeTask(String id);

  Future<Either<Failure, TaskEntity>> updateTask(
      TaskDataRequest taskData, String id);
}
