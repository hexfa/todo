import 'package:todo/domain/entities/project.dart';

abstract class ProjectProvider {
  void setCurrentProject(Project project);

  Project getProjectName();
}
