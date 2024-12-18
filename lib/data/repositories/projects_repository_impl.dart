import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/projects_repository.dart';
import '../datasources/projects_remote_datasource.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsRemoteDataSource remoteDataSource;

  ProjectsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    try {
      final models = await remoteDataSource.getProjects();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Project>> createProject(String name) async {
    try {
      var requestId = const Uuid().v4();

      final response = await remoteDataSource.createProjects(name, requestId);
      return Right(response.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String id)async {
    try {

      final response = await remoteDataSource.deleteProjects(id);

      return  Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
