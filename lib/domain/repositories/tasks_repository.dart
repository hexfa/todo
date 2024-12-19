import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/task.dart';

import '../../data/models/task_data_request.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks();

  Future<Either<Failure, TaskEntity>> createTask(TaskDataRequest taskData);

  Future<Either<Failure, bool>> deleteTask(String id);
}
