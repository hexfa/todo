import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/presentation/bloc/project_bloc.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/project_page.dart';
import 'package:todo/presentation/views/task/create/create_task_screen.dart';

import '../views/project_page.dart';

class AppRouter {
  final Storage storage;

  AppRouter({required this.storage});

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutePath.homeRoute,
    routes: [
      GoRoute(
        path: AppRoutePath.homeRoute,
        builder: (context, state) {
          return BlocProvider<ProjectsBloc>(
            create: (context) => getIt<ProjectsBloc>(),
            child:  ProjectsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutePath.addTaskRoute,
        builder: (context, state) => CreateTaskScreen(),
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text('404 - Page not found')),
    ),
  );
}
