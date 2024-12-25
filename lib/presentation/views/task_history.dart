import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/presentation/bloc/task/task_bloc.dart';
import 'package:todo/presentation/bloc/task/task_state.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/state_widget.dart';
import 'package:todo/presentation/views/task_tile.dart';

import '../bloc/task/task_event.dart';

class TaskHistory extends StatefulWidget {
  const TaskHistory({super.key});

  @override
  State<TaskHistory> createState() => _TaskHistoryState();
}

class _TaskHistoryState extends BaseState<TaskHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocProvider(
      create: (context) => getIt<TasksBloc>()..add(FetchTasksEvent('')),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          localization.taskHistory,
          style: theme.textTheme.titleMedium
              ?.copyWith(color: theme.colorScheme.onPrimary),
        )),
        body: BlocConsumer<TasksBloc, TasksState>(
          listener: (context, state) {
            if (state is TasksError) {
              context.read<TasksBloc>().add(FetchTasksEvent(''));
            }
          },
          builder: (context, state) {
            if (state is TasksLoading) {
              return const StateWidget(isLoading: true, null);
            } else if (state is TasksLoaded) {
              final filteredTasks =
                  state.tasks.where((task) => task.priority == 3).toList();
              if (filteredTasks.isEmpty) {
                return const StateWidget(isLoading: false, '');
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: filteredTasks.length,
                  itemBuilder: (gridContext, index) {
                    final task = filteredTasks[index];
                    return TaskTile(
                        task: task,
                        onDeleteConfirm: () {
                          context
                              .read<TasksBloc>()
                              .add(DeleteEvent(task.id, ''));
                        });
                  },
                );
              }
            } else if (state is TasksError) {
              return Center(child: Text(localization.somethingWentWrong));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
