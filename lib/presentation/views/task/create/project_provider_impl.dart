// project_provider_impl.dart

import 'package:todo/domain/entities/project.dart';

import 'project_provider.dart';

class ProjectProviderImpl implements ProjectProvider {
  Project? _currentProject;




  @override
  Project getProjectName() {
    return _currentProject!;
  }

  @override
  void setCurrentProject(Project project) {
    _currentProject=project;
  }
}
