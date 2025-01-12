import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/project.dart';

abstract class ProjectsRepository {
  Future<Either<Failure, List<Project>>> getProjects();

  Future<Either<Failure, Project>> createProject(String name);

  Future<Either<Failure, bool>> deleteProject(String id);
}
