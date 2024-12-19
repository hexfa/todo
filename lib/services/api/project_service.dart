
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:todo/data/models/project_model_response.dart';
import 'package:todo/data/models/task_data_request.dart';

import '../../core/constants/constants_value.dart';
import '../../data/models/task_model_response.dart';

part 'project_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ProjectService {
  factory ProjectService(Dio dio, {String baseUrl}) = _ProjectService;

  @GET("projects")
  Future<List<ProjectModelResponse>> getProjects();
  
  @DELETE("projects/{id}")
  Future<void> deleteProjects(@Path('id') String projectId);

  @POST("projects")
  Future<ProjectModelResponse> createProject(
    @Body() Map<String, dynamic> body,
    @Header("X-Request-Id") String requestId,
  );

  @GET("tasks")
  Future<List<TaskModelResponse>> getTasks();

  @POST("tasks")
  Future<TaskModelResponse> createTask(
      @Body() TaskDataRequest taskData,
      );

  @DELETE("tasks/{id}")
  Future<void> deleteTask(
      @Path("id") String id,
      );

}
