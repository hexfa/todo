import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/services/api/project_service.dart';

import '../../../domain/entities/task.dart';

abstract class TasksRemoteDataSource {
  Future<List<TaskModelResponse>> getTasks({required String projectId});

  Future<TaskModelResponse> getTask(String? taskId);

  Future<TaskModelResponse> createTask(TaskDataRequest taskData);

  Future<bool> deleteTask(String id);

  Future<bool> closeTask(String id);

  Future<TaskModelResponse> updateTask(TaskDataRequest taskData, String id);
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final ProjectService service;

  TasksRemoteDataSourceImpl({
    required this.service,
  });

  /*@override
  Future<Either<Failure, List<TaskEntity>>> getTasks(String projectId) async {
    try {
      final tasks = await service.getTasks(projectId);
      return tasks;
    } catch (e) {
      throw ServerFailure(message: 'Failed to fetch tasks ${e.toString()}');
    }
  }*/

  @override
  Future<TaskModelResponse> createTask(TaskDataRequest taskData) async {
    try {
      return await service.createTask(taskData);
    } catch (e) {
      print('-----------------------create task ${e.toString()}');
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
  Future<TaskModelResponse> updateTask(
      TaskDataRequest taskData, String id) async {
    try {
      return await service.updateTask(taskData, id);
    } catch (e) {
      throw const ServerFailure(message: 'Failed to update task');
    }
  }

  @override
  Future<TaskModelResponse> getTask(String? taskId) async {
    try {
      final task = await service.getTask(taskId ?? '');
      return task;
    } catch (e) {
      throw const ServerFailure(message: 'Failed to get task');
    }
  }

  @override
  Future<List<TaskModelResponse>> getTasks({required String projectId}) async {
    try {
      final tasks = await service.getTasks(projectId);
      return tasks;
    } catch (e) {
      throw ServerFailure(message: 'Failed to fetch tasks ${e.toString()}');
    }
  }
}
