import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/project_page.dart';


class AppRouter {
  final Storage storage;

  AppRouter({required this.storage});

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutePath.homeRoute,
    routes: [
      GoRoute(
        path: AppRoutePath.homeRoute,
        builder: (context, state) =>  ProjectsPage(),
      ),

    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text('404 - Page not found')),
    ),
  );
}
