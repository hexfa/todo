import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/tasks_remote_datasource.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/data/models/task_model_response.dart';

import '../../services/api/project_service.dart';

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final ProjectService service;

  TasksRemoteDataSourceImpl({
    required this.service,
  });

  @override
  Future<List<TaskModelResponse>> getTasks() async {
    try {
      final tasks = await service.getTasks();
      return tasks;
    } catch (e) {
      throw const ServerFailure(message: 'Failed to fetch tasks');
    }
  }

  @override
  Future<TaskModelResponse> createTask(
      TaskDataRequest taskData
      ) async {
    try {

      return await service.createTask(
        taskData);
    } catch (e) {
      throw const ServerFailure(message: 'Failed to create task');
    }
  }

  @override
  Future<bool> deleteTask(String id) async {
    try {
      await service.deleteTask(
        id,
      );
      return true; // Indicate success
    } catch (e) {
      throw const ServerFailure(message: 'Failed to delete task');
    }
  }

  @override
  Future<bool> closeTask(String id) async {
    try {
      await service.closeTask(id);
      return true;
    } catch (e) {
      throw const ServerFailure(message: 'Failed to close task');
    }
  }

  @override
  Future<TaskModelResponse> updateTask(TaskDataRequest taskData, String id) async{
    try {
     return await service.updateTask(
        taskData,id
      );
    } catch (e) {
      throw const ServerFailure(message: 'Failed to update task');
    }
  }
}
