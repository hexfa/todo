import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/core/constants/constants_value.dart';
import 'package:todo/data/datasources/local/sync_local_datasource.dart';
import 'package:todo/data/models/project_model_response.dart';
import 'package:todo/data/models/sync_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/projects_repository.dart';
import '../datasources/local/projects_local_datasource.dart';
import '../datasources/remote/projects_remote_datasource.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsRemoteDataSource remoteDataSource;
  final ProjectsLocalDataSource localDataSource;
  final SyncLocalDataSource syncQueue;

  ProjectsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.syncQueue,
  });

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    try {
      final localProjects = await localDataSource.getProjects();
      if (localProjects.isNotEmpty) {
        return Right(localProjects.map((m) => m.toEntity()).toList());
      }

      final remoteProjects = await remoteDataSource.getProjects();
      await localDataSource.saveProjects(remoteProjects);
      return Right(remoteProjects.map((m) => m.toEntity()).toList());
    } catch (e) {
      return const Left(ServerFailure(message: 'Unexpected Error'));
    }
  }

  @override
  Future<Either<Failure, Project>> createProject(String name) async {
    try {
      if (await _isConnected()) {
        final response = await remoteDataSource.createProjects(name);
        await localDataSource.saveProject(response);
        return Right(response.toEntity());
      } else {
        final tempProject = ProjectModelResponse(
          id: const Uuid().v4(),
          name: name,
          commentCount: 0,
          order: 0,
          color: '',
          isShared: false,
          isFavorite: false,
          isInboxProject: false,
          isTeamInbox: false,
          viewStyle: '',
          url: '',
        );
        await localDataSource.saveProject(tempProject);
        await syncQueue.addOperation(SyncOperation(
          type: 'create',
          id: tempProject.id,
          data: tempProject.toJson(),
          entityType: 'project',
        ));
        return Right(tempProject.toEntity());
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProject(String id) async {
    try {
      if (await _isConnected()) {
        final result = await remoteDataSource.deleteProjects(id);
        await localDataSource.deleteProject(id);
        return Right(result);
      } else {
        await localDataSource.deleteProject(id);
        await syncQueue.addOperation(SyncOperation(
          type: 'delete',
          id: id,
          entityType: 'project',
          data: {}
        ));
        return const Right(true);
      }
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to delete project'));
    }
  }

  Future<bool> _isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    // Check if connected to either mobile data or WiFi
    if (connectivityResult.first == ConnectivityResult.mobile || connectivityResult.first == ConnectivityResult.wifi) {

      return true;
    }

    return false;
  }
}
