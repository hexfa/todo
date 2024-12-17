// lib/features/projects/presentation/pages/projects_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/presentation/views/app_drawer.dart';
import 'package:todo/presentation/views/state_widget.dart';

import '../bloc/project_bloc.dart';
import '../bloc/project_event.dart';
import '../bloc/project_state.dart';

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: FAB(),
      appBar: AppBar(title: Text('Projects')),
      body: BlocProvider(
        create: (context) => getIt<ProjectsBloc>()..add(FetchProjectsEvent()),
        child: BlocConsumer<ProjectsBloc, ProjectsState>(
          listener: (context, state) {
            if (state is ProjectsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is ProjectsLoading) {
              return  StateWidget(isLoading: true,null);
            } else if (state is ProjectsLoaded) {
              if (state.projects.isEmpty) {
                return  StateWidget(isLoading: false,'Create a new project');
              } else {
                return ListView.builder(
                  itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  final project = state.projects[index];
                  return ListTile(
                    hoverColor: Colors.pink,
                    title: Text(project.name),
                    subtitle: Text(
                        'ID: ${project.id}, Comments: ${project.commentCount}'),
                  );
                },
              );
              }
            } else if (state is ProjectsError) {
              return const Center(child: Text('Something went wrong!'));
            }
            return   StateWidget(isLoading: false,'Create a new project.');
          },
        ),
      ),
    );
  }
}

class FAB extends StatelessWidget {
  const FAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProjectsBloc>().add(FetchProjectsEvent());
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        color: Colors.blue,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
              child: Icon(
            Icons.add,
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
