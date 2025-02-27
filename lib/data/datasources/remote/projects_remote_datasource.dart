import 'package:todo/core/error/failure.dart';
import 'package:todo/data/models/project_model_response.dart';
import 'package:todo/services/api/project_service.dart';

abstract class ProjectsRemoteDataSource {
  Future<List<ProjectModelResponse>> getProjects();

  Future<bool> deleteProjects(String id);

  Future<ProjectModelResponse> createProjects(String name);
}

class ProjectsRemoteDataSourceImpl implements ProjectsRemoteDataSource {
  final ProjectService service;

  ProjectsRemoteDataSourceImpl(this.service);

  @override
  Future<List<ProjectModelResponse>> getProjects() async {
    try {
      return await service.getProjects();
    } catch (e) {
      throw const ServerFailure(message: 'Failed to fetch projects');
    }
  }

  @override
  Future<ProjectModelResponse> createProjects(String name) async {
    try {
      return await service.createProject({"name": name});
    } catch (e) {
      throw const ServerFailure(message: 'Failed to create project');
    }
  }

  @override
  Future<bool> deleteProjects(String id) async {
    try {
      await service.deleteProjects(id);
      return true; // Indicate success
    } catch (e) {
      throw const ServerFailure(message: 'Failed to delete project');
    }
  }
}
