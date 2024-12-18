// lib/presentation/views/tasks_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task/task_bloc.dart';
import '../bloc/task/task_event.dart';
import '../bloc/task/task_state.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<TasksBloc>()..add(FetchTasksEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Active Tasks'),
        ),
        body: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state is TasksLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TasksLoaded) {
              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text('Due: ${task.due?.date ?? 'No due date'}'),
                    trailing: Icon(
                      task.isCompleted ? Icons.check_circle : Icons.circle,
                      color: task.isCompleted ? Colors.green : Colors.grey,
                    ),
                  );
                },
              );
            } else if (state is TasksError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
