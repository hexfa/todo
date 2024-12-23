// lib/domain/usecases/close_task_usecase.dart

import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../repositories/tasks_repository.dart';
import 'base_usecase.dart';

class CloseTaskUseCase extends UseCase<bool, String> {
  final TasksRepository repository;

  CloseTaskUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String id) async {
    try {
      return await repository.closeTask(id);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to close task'));
    }
  }}
