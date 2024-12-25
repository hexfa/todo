import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/repositories/projects_repository.dart';

import 'base_usecase.dart';

class DeleteProjectUseCase implements UseCase<bool, String> {
  final ProjectsRepository repository;

  DeleteProjectUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.deleteProject(params);
  }
}
