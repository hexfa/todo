
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/project.dart';
import '../repositories/projects_repository.dart';
import 'base_usecase.dart';

class GetProjectsUseCase implements UseCase<Either<Failure, List<Project>>, NoParams> {
  final ProjectsRepository repository;

  GetProjectsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Project>>> call(NoParams params) {
    return repository.getProjects();
  }
}

class NoParams {}