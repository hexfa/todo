
import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/repositories/projects_repository.dart';

import 'base_usecase.dart';


class GetProjectsUseCase implements UseCase<List<Project>, NoParams> {
  final ProjectsRepository repository;

  GetProjectsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Project>>> call(NoParams params) async {
    return await repository.getProjects();
  }
}

class NoParams {
}
