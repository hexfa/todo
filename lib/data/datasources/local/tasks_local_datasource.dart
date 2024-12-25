import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/models/task_model_response.dart';

abstract class TasksLocalDataSource {
  Future<void> saveTasks(List<TaskModelResponse> tasks);

  Future<void> saveTask(TaskModelResponse task);
  Future<List<TaskModelResponse>> getTasks({String? projectId});

  Future<void> deleteTask(String id);

  Future<void> deleteTasksByProject(String projectId);
}

class TasksLocalDataSourceImpl implements TasksLocalDataSource {
  final Box<TaskModelResponse> taskBox;

  TasksLocalDataSourceImpl(this.taskBox);

  @override
  Future<void> saveTasks(List<TaskModelResponse> tasks) async {
    for (var task in tasks) {
      await taskBox.put(task.id, task);
    }
  }

  @override
  Future<void> saveTask(TaskModelResponse task) async {
    await taskBox.put(task.id, task);
  }

  @override
  Future<List<TaskModelResponse>> getTasks({String? projectId}) async {
    if (projectId != null) {
      return taskBox.values
          .where((task) => task.projectId == projectId)
          .toList();
    }
    return taskBox.values.toList();
  }

  @override
  Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }

  @override
  Future<void> deleteTasksByProject(String projectId) async {
    final tasksToDelete = taskBox.values
        .where((task) => task.projectId == projectId)
        .map((task) => task.id)
        .toList();
    for (var id in tasksToDelete) {
      await taskBox.delete(id);
    }
  }
}
