import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../repositories/tasks_repository.dart';
import 'base_usecase.dart';

class CloseTaskUseCase extends UseCase<bool, String> {
  final TasksRepository repository;

  CloseTaskUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    try {
      return await repository.closeTask(params);
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to close task'));
    }
  }
}
