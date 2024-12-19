import 'package:todo/data/models/task_model_response.dart';

abstract class TasksRemoteDataSource {
  Future<List<TaskModelResponse>> getTasks(String? projectId);
}
