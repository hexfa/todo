import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/local/sync_local_datasource.dart';
import 'package:todo/data/datasources/local/tasks_local_datasource.dart';
import 'package:todo/data/datasources/remote/tasks_remote_datasource.dart';
import 'package:todo/data/models/sync_model.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';
import 'package:uuid/uuid.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource remoteDataSource;
  final TasksLocalDataSource localDataSource;
  final SyncLocalDataSource syncQueue;

  TasksRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.syncQueue,
  });

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks(String? projectId) async {
    try {
      final localTasks = await localDataSource.getTasks(projectId: projectId);
      if (localTasks.isNotEmpty) {
        return Right(localTasks.map((t) => t.toEntity()).toList());
      }

      final remoteTasks =
          await remoteDataSource.getTasks(projectId: projectId!);
      await localDataSource.saveTasks(remoteTasks);
      return Right(remoteTasks.map((t) => t.toEntity()).toList());
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected Error ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> createTask(
      TaskDataRequest taskData) async {
    try {
      if (await _isConnected()) {
        final taskModel = await remoteDataSource.createTask(taskData);
        await localDataSource.saveTask(taskModel);
        return Right(taskModel.toEntity());
      } else {
        final tempTask = TaskModelResponse(
          id: const Uuid().v4(),
          projectId: taskData.projectId ?? '',
          description: '',
          creatorId: '',
          createdAt: '',
          labels: [],
          url: '',
          commentCount: 0,
          isCompleted: false,
          content: taskData.content ?? '',
          order: 1,
          priority: 1,
        );
        await localDataSource.saveTask(tempTask);
        await syncQueue.addOperation(SyncOperation(
          type: 'create',
          id: tempTask.id,
          data: taskData.toJson(),
          entityType: 'task',
        ));
        return Right(tempTask.toEntity());
      }
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to create task'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask(String id) async {
    try {
      if (await _isConnected()) {
        final result = await remoteDataSource.deleteTask(id);
        await localDataSource.deleteTask(id);
        return Right(result);
      } else {
        await localDataSource.deleteTask(id);
        await syncQueue.addOperation(SyncOperation(
          type: 'delete',
          id: id,
          entityType: 'task',
        ));
        return const Right(true);
      }
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to delete task'));
    }
  }

  @override
  Future<Either<Failure, bool>> closeTask(String id) async {
    try {
      if (await _isConnected()) {
        final result = await remoteDataSource.closeTask(id);
        await localDataSource.deleteTask(id);
        return Right(result);
      } else {
        await localDataSource.deleteTask(id);
        await syncQueue.addOperation(SyncOperation(
          type: 'close',
          id: id,
          entityType: 'task',
        ));
        return const Right(true);
      }
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to close task'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> getTask(String? taskId) async {
    try {
      // if (await _isConnected()) {
      final result = await remoteDataSource.getTask(taskId);
      print('-------------------repo${result.creatorId}');
      // await localDataSource.getTask(id);
      return Right(result.toEntity());
      // } else {
      //   await localDataSource.getTask(id);
      //   await syncQueue.addOperation(SyncOperation(
      //     type: 'get',
      //     id: id,
      //     entityType: 'task',
      //   ));
      //   return const Right(true);
      // }
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to close task'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(
      TaskDataRequest taskData, String id) async {
    try {
      if (await _isConnected()) {
        final response = await remoteDataSource.updateTask(taskData, id);
        final tasks = await localDataSource.getTasks();
        final taskIndex = tasks.indexWhere((task) => task.id == id);
        if (taskIndex != -1) {
          tasks[taskIndex] = response;
          await localDataSource.saveTasks(tasks);
        }
        return Right(response.toEntity());
      } else {
        final tasks = await localDataSource.getTasks();
        final taskIndex = tasks.indexWhere((task) => task.id == id);
        final tempTask = TaskModelResponse(
          id: tasks[taskIndex].id,
          projectId: tasks[taskIndex].projectId,
          description: tasks[taskIndex].description,
          creatorId: tasks[taskIndex].creatorId,
          createdAt: tasks[taskIndex].createdAt,
          labels: tasks[taskIndex].labels,
          url: tasks[taskIndex].url,
          commentCount: tasks[taskIndex].commentCount,
          isCompleted: tasks[taskIndex].isCompleted,
          content: taskData.content ?? '',
          order: tasks[taskIndex].order,
          priority: taskData.priority ?? 1,
        );
        tasks[taskIndex] = tempTask;
        await localDataSource.saveTasks(tasks);
        await syncQueue.addOperation(SyncOperation(
          type: 'update',
          id: id,
          data: taskData.toJson(),
          entityType: 'task',
        ));
        return Right(tempTask.toEntity());
      }
    } catch (e) {
      return const Left(ServerFailure(message: 'Failed to update task'));
    }
  }

  Future<bool> _isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.first == ConnectivityResult.mobile ||
        connectivityResult.first == ConnectivityResult.wifi) {
      print('is conected true');
      return true;
    }
    print('is conected false');

    return false;
  }
}
