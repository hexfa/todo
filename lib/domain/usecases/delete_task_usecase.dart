import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repositories/tasks_repository.dart';
import 'base_usecase.dart';

class DeleteTaskUseCase extends UseCase<bool, String> {
  final TasksRepository repository;

  DeleteTaskUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String id) async {
    try {
      return await repository.deleteTask(id);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to close task'));
    }
  }
}