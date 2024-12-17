
import 'package:todo/data/models/project_model_response.dart';
import 'package:todo/services/api/project_service.dart';

abstract class ProjectsRemoteDataSource {
  Future<List<ProjectModelResponse>> getProjects();
}

class ProjectsRemoteDataSourceImpl implements ProjectsRemoteDataSource {
  final ProjectService service;

  ProjectsRemoteDataSourceImpl(this.service);

  @override
  Future<List<ProjectModelResponse>> getProjects() async {
    return await service.getProjects();
  }
}
