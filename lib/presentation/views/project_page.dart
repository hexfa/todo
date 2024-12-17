// lib/features/projects/presentation/pages/projects_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';

import '../bloc/project_bloc.dart';
import '../bloc/project_event.dart';
import '../bloc/project_state.dart';

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projects')),
      body: BlocProvider(
        create: (context) =>  getIt<ProjectsBloc>(),
        child: BlocBuilder<ProjectsBloc, ProjectsState>(
          builder: (context, state) {
            if (state is ProjectsInitial) {
              print("ProjectsInitial");
              context.read<ProjectsBloc>().add(FetchProjectsEvent());
              return Center(child: Text('Loading...'));
            } else if (state is ProjectsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProjectsLoaded) {
              return ListView.builder(
                itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  final project = state.projects[index];
                  return ListTile(
                    title: Text(project.name),
                    subtitle: Text(
                        'ID: ${project.id}, Comments: ${project.commentCount}'),
                  );
                },
              );
            } else if (state is ProjectsError) {
              return Center(child: Text(state.message));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
