import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/repositories/projects_repository.dart';

import 'base_usecase.dart';

class CreateProjectUseCase extends UseCase<Project, String> {
  final ProjectsRepository repository;

  CreateProjectUseCase(this.repository);

  @override
  Future<Either<Failure, Project>> call(String params) async {
    return await repository.createProject(params);
  }
}
