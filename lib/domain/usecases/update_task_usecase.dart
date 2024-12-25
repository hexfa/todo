import 'package:dartz/dartz.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';

import '../../core/error/failure.dart';
import '../entities/task.dart';
import 'base_usecase.dart';

class UpdateTaskUseCase implements UseCase<TaskEntity, UpdateTaskParams> {
  final TasksRepository repository;

  UpdateTaskUseCase(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(UpdateTaskParams params) async {
    try {
      return await repository.updateTask(params.taskData, params.id);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

class UpdateTaskParams {
  final String id;
  final TaskDataRequest taskData;

  UpdateTaskParams({required this.id, required this.taskData});
}
