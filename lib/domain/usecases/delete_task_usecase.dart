import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repositories/tasks_repository.dart';
import 'base_usecase.dart';

class DeleteTaskUseCase extends UseCase<bool, String> {
  final TasksRepository repository;

  DeleteTaskUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.deleteTask(params);
  }
}
