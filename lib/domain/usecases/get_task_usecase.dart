import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';
import 'base_usecase.dart';

class GetTaskUseCase extends UseCase<TaskEntity, String> {
  final TasksRepository repository;

  GetTaskUseCase(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(String params) async {
    return await repository.getTask(params);
  }
}
