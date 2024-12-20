import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/presentation/bloc/update_task/update_task_bloc.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/project_page.dart';
import 'package:todo/presentation/views/task/create/create_task_screen.dart';
import 'package:todo/presentation/views/task/update/update_task_screen.dart';
import 'package:todo/presentation/views/tasks_page.dart';

class AppRouter {
  final Storage storage;

  AppRouter({required this.storage});

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutePath.homeRoute,
    routes: [
      // Home Route
      GoRoute(
        path: AppRoutePath.homeRoute,
        builder: (context, state) => ProjectsPage(),
      ),

      // Task List Route
      GoRoute(
        path: '${AppRoutePath.taskListRoute}/:taskId',
        builder: (context, state) {
          final taskId = state.pathParameters['taskId'];
          if (taskId == null || taskId.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('Project ID is missing')),
            );
          }
          return TasksPage(projectId: taskId);
        },
      ),

      // Add Task Route
      GoRoute(
        path: AppRoutePath.addTaskRoute,
        builder: (context, state) => CreateTaskScreen(),
      ),
      GoRoute(
        path: '${AppRoutePath.updateTaskRoute}/:taskId',
        builder: (context, state) {
          final taskId = state.pathParameters['taskId'];
          if (taskId == null || taskId.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('Task ID is missing')),
            );
          }
          return BlocProvider(
            create: (context) => getIt<UpdateTaskBloc>(),
            child: UpdateTaskScreen(taskId: taskId),
          );
        },
      ),
    ],

    // Error Page for unknown routes
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('404 - Page not found')),
      body: const Center(
          child: Text('404 - The page you are looking for does not exist.')),
    ),
  );
}
