// lib/features/projects/presentation/pages/projects_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/presentation/views/app_drawer.dart';
import 'package:todo/presentation/views/state_widget.dart';

import '../bloc/project_bloc.dart';
import '../bloc/project_event.dart';
import '../bloc/project_state.dart';

class ProjectsPage extends StatefulWidget {
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocProvider(
      create: (context) => getIt<ProjectsBloc>()..add(FetchProjectsEvent()),
      child: Scaffold(
        drawer: AppDrawer(),
        floatingActionButton: FAB(),
        appBar: AppBar(title: Text('Projects')),
        body: BlocConsumer<ProjectsBloc, ProjectsState>(
          listener: (context, state) {
            if (state is ProjectsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              context.read<ProjectsBloc>().add(FetchProjectsEvent());
            }
            if (state is ProjectCreateSuccess) {
              context.read<ProjectsBloc>().add(FetchProjectsEvent());
            }
            if(state is DeleteProjectState){
              context.read<ProjectsBloc>().add(FetchProjectsEvent());
            }
          },
          builder: (context, state) {
            if (state is ProjectsLoading) {
              return StateWidget(isLoading: true, null);
            } else if (state is ProjectsLoaded) {
              if (state.projects.isEmpty) {
                return StateWidget(isLoading: false, 'Create a new project');
              } else {
                return ListView.builder(
                  itemCount: state.projects.length,
                  itemBuilder: (listContext, index) {
                    final project = state.projects[index];
                    return  Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        hoverColor: Colors.pink[50],
                        title: Text(project.name),
                        trailing:project.name!='Inbox'? IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: listContext,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text('Are you sure you want to delete this project?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<ProjectsBloc>().add(DeleteProjectEvent(project.id));
                                        Navigator.of(dialogContext).pop();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ):SizedBox.shrink(),
                      ),
                    );
                  },
                );
              }
            } else if (state is ProjectsError) {
              return const Center(child: Text('Something went wrong!'));
            }
            return StateWidget(isLoading: false, 'Create a new project.');
          },
        ),
      ),
    );
  }
}

class FAB extends StatefulWidget {
  FAB({Key? key}) : super(key: key);

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: buildContext,
          builder: (BuildContext dialogContex) {
            return AlertDialog(
              title: const Text('Create Project'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Project Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        final name = _controller.text.trim();
                        if (name.isNotEmpty) {
                          context.read<ProjectsBloc>().add(
                              CreateProjectEvent(name));
                          _controller.clear();
                          Navigator.of(dialogContex).pop(); // Close the dialog
                        } else {
                          ScaffoldMessenger.of(dialogContex).showSnackBar(
                            const SnackBar(
                                content: Text('Please enter a project name')),
                          );
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Create Project'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
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
