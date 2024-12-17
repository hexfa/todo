import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/project_bloc.dart';
import '../bloc/project_event.dart';
import '../bloc/project_state.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProjectsBloc>().add(FetchProjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // دکمه ایجاد پروژه
            ElevatedButton.icon(
              onPressed: () {
                final name = _controller.text.trim();
                if (name.isNotEmpty) {
                  context.read<ProjectsBloc>().add(CreateProjectEvent(name));
                  _controller.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter a project name')),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Create Project'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocConsumer<ProjectsBloc, ProjectsState>(
                listener: (context, state) {
                  if (state is ProjectCreateSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Project "${state.project.name}" created successfully!')),
                    );
                  } else if (state is ProjectFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.message}')),
                    );
                  } else if (state is ProjectsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.message}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProjectsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProjectsLoaded) {
                    if (state.projects.isEmpty) {
                      return const Center(child: Text('No projects found.'));
                    }
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
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
