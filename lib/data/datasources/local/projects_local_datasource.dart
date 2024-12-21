import 'package:hive/hive.dart';
import 'package:todo/data/models/project_model_response.dart';

abstract class ProjectsLocalDataSource {
  Future<void> saveProjects(List<ProjectModelResponse> projects);
  Future<void> saveProject(ProjectModelResponse project);
  Future<List<ProjectModelResponse>> getProjects();
  Future<void> deleteProject(String id);
}

class ProjectsLocalDataSourceImpl implements ProjectsLocalDataSource {
  final Box<ProjectModelResponse> projectBox;

  ProjectsLocalDataSourceImpl(this.projectBox);

  @override
  Future<void> saveProjects(List<ProjectModelResponse> projects) async {
    await projectBox.clear(); // Clear old data
    for (var project in projects) {
      await projectBox.put(project.id, project); // Save projects
    }
  }

  @override
  Future<void> saveProject(ProjectModelResponse project) async {
    await projectBox.put(project.id, project);
  }

  @override
  Future<List<ProjectModelResponse>> getProjects() async {
    return projectBox.values.toList();
  }

  @override
  Future<void> deleteProject(String id) async {
    print('sync delete');

    await projectBox.delete(id);
    print('sync delete 2 ');

  }
}
