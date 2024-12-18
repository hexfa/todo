import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/project.dart';
import '../repositories/projects_repository.dart';
import 'base_usecase.dart';

class DeleteUseCase {
  final ProjectsRepository repository;

  DeleteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) {
    return repository.deleteProject(id);
  }
}

