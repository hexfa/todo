import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/presentation/bloc/task/task_bloc.dart';
import 'package:todo/presentation/bloc/task/task_event.dart';
import 'package:todo/presentation/bloc/task/task_state.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/state_widget.dart';


class TasksPage extends StatefulWidget {
  final String taskId;

  const TasksPage({Key? key, required this.taskId}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends BaseState<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: BlocProvider(
        create: (context) =>
            getIt<TasksBloc>()..add(FetchTasksEvent(widget.taskId)),
        child: Scaffold(
          appBar: AppBar(
              title: Text(
            'Active Tasks',
            style: theme.textTheme.titleMedium
                ?.copyWith(color: theme.colorScheme.onPrimary),
          )),
          body: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TasksLoading) {
                return Center(child: StateWidget(isLoading: true, null));
              } else if (state is TasksLoaded) {
                if (state.tasks.isEmpty) {
                  return StateWidget(
                      isLoading: false, 'localization.createProject');
                }
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
      ),
    );
  }
}
