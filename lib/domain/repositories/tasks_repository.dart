
import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/task.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks(String? projectId);
}
