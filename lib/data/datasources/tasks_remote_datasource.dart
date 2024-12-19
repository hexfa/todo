import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/data/models/task_model_response.dart';

abstract class TasksRemoteDataSource {
  Future<List<TaskModelResponse>> getTasks();
  Future<TaskModelResponse> createTask(TaskDataRequest taskData);

  Future<bool> deleteTask(String id);
  Future<bool> closeTask(String id);
}
