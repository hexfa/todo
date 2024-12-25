import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:todo/data/datasources/local/projects_local_datasource.dart';
import 'package:todo/data/datasources/local/sync_local_datasource.dart';
import 'package:todo/data/datasources/local/tasks_local_datasource.dart';
import 'package:todo/data/datasources/remote/projects_remote_datasource.dart';
import 'package:todo/data/datasources/remote/tasks_remote_datasource.dart';
import 'package:todo/data/models/sync_model.dart';
import 'package:todo/data/models/task_data_request.dart';

class SyncManager {
  final SyncLocalDataSource syncQueue;
  final ProjectsRemoteDataSource projectsRemoteDataSource;
  final TasksRemoteDataSource tasksRemoteDataSource;
  final ProjectsLocalDataSource projectsLocalDataSource;
  final TasksLocalDataSource tasksLocalDataSource;

  SyncManager({
    required this.syncQueue,
    required this.projectsRemoteDataSource,
    required this.tasksRemoteDataSource,
    required this.projectsLocalDataSource,
    required this.tasksLocalDataSource,
  });

  Future<void> sync() async {
    final operations = await syncQueue.getOperations();
    for (int i = 0; i < operations.length; i++) {
      final operation = operations[i];

      try {
        if (operation.entityType == 'project') {
          await _syncProjectOperation(operation);
        } else if (operation.entityType == 'task') {
          await _syncTaskOperation(operation);
        }
        await syncQueue.removeOperation(i); // Remove from queue if successful
      } catch (e) {
        print(
            'Sync failed for operation ${operation.type} on ${operation.entityType}: $e');
      }
    }
  }

  Future<void> _syncProjectOperation(SyncOperation operation) async {
    switch (operation.type) {
      case 'create':
        {
          try {
            var response = await projectsRemoteDataSource
                .createProjects(operation.data!['name']);
            await projectsLocalDataSource.deleteProject(operation.id);
            await projectsLocalDataSource.saveProject(response);
            break;
          } catch (e) {
            print('create errrrrr is $e');
          }
        }
      case 'delete':
        {
          await projectsRemoteDataSource.deleteProjects(operation.id);
          await projectsLocalDataSource.deleteProject(operation.id);
          break;
        }
      default:
        throw Exception(
            'Unknown operation type for project: ${operation.type}');
    }
  }

  Future<void> _syncTaskOperation(SyncOperation operation) async {
    switch (operation.type) {
      case 'create':
        final taskData = TaskDataRequest.fromJson(operation.data!);
        await tasksRemoteDataSource.createTask(taskData);
        break;
      case 'update':
        {
          final taskData = TaskDataRequest.fromJson(operation.data!);
          await tasksRemoteDataSource.updateTask(taskData, operation.id);
          break;
        }
      case 'delete':
        await tasksRemoteDataSource.deleteTask(operation.id);
        break;
      default:
        throw Exception('Unknown operation type for task: ${operation.type}');
    }
  }

  void monitorConnection() {
    Connectivity().onConnectivityChanged.listen((result) async {
      print('sync connectivity ');

      if (result.first == ConnectivityResult.mobile ||
          result.first == ConnectivityResult.wifi) {
        print('sync connectivity true');

        await sync();
      }
    });
  }
}
