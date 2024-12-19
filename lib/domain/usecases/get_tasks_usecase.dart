import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';

import 'base_usecase.dart';
import 'no_param.dart';

class GetTasksUseCase extends UseCase<List<TaskEntity>, TasksParams> {
  final TasksRepository repository;

  GetTasksUseCase(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(TasksParams params) async {
    return await repository.getTasks(params.projectId);
  }
}
class TasksParams {
  String projectId;
  TasksParams(this.projectId);
}
