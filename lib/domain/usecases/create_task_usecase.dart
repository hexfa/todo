import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/task_data_request.dart';
import '../entities/task.dart';
import '../repositories/tasks_repository.dart';
import 'base_usecase.dart';

class CreateTaskUseCase extends UseCase<TaskEntity, TaskDataRequest> {
  final TasksRepository repository;

  CreateTaskUseCase(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(TaskDataRequest params) async {
    return await repository.createTask(params);
  }
}
