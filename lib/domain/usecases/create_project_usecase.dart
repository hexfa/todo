import 'package:dartz/dartz.dart';
import 'package:todo/domain/repositories/projects_repository.dart';

import '../../core/error/failure.dart';
import '../entities/project.dart';

class CreateProjectUseCase {
  final ProjectsRepository repository;

  CreateProjectUseCase(this.repository);

  Future<Either<Failure, Project>> call(String name) async {
    return await repository.createProject(name);
  }
}
