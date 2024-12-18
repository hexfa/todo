import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/tasks_remote_datasource.dart';
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
}
