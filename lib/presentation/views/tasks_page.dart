import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/presentation/bloc/task/task_bloc.dart';
import 'package:todo/presentation/bloc/task/task_event.dart';
import 'package:todo/presentation/bloc/task/task_state.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/dialog.dart';
import 'package:todo/presentation/views/state_widget.dart';

class TasksPage extends StatefulWidget {
  final String taskId;
  const TasksPage({super.key, required this.taskId});
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends BaseState<TasksPage> {
  late BoardViewController boardViewController;
  @override
  void initState() {
    super.initState();
    boardViewController = BoardViewController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<TasksBloc>()..add(FetchTasksEvent(widget.taskId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            localization.kanbanBoard,
            style: theme.textTheme.titleMedium
                ?.copyWith(color: theme.colorScheme.onPrimary),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: theme.colorScheme.onPrimary),
              onPressed: () {
                // TODO: Add functionality to create a new task
              },
            ),
          ],
        ),
        body: BlocConsumer<TasksBloc, TasksState>(
          listener: (context, state) {
            if (state is TasksError) {
              context.read<TasksBloc>().add(FetchTasksEvent(widget.taskId));
            }
          },
          builder: (context, state) {
            if (state is TasksLoading) {
              return Center(
                  child:
                      StateWidget(isLoading: true, localization.createProject));
            } else if (state is TasksLoaded) {
              final sections = state.sections;
              final boardLists = sections.map((section) {
                final tasksInSection = state.tasks.where((task) {
                  return task.priority.toString() == section.id.toString();
                }).toList();

                return BoardList(
                  headerBackgroundColor:
                      theme.colorScheme.primary.withOpacity(0.6),
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.3),
                  header: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        section.name,
                        style: theme.textTheme.titleSmall
                            ?.copyWith(color: theme.colorScheme.onPrimary),
                      ),
                    )
                  ],
                  items: tasksInSection.map((task) {
                    return BoardItem(
                      onDropItem: (int? oldListIndex,
                          int? oldItemIndex,
                          int? newListIndex,
                          int? newItemIndex,
                          BoardItemState state) {},
                      item: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            showCustomDialog(
                                context: context,
                                title: localization.confirmDeletion,
                                content: localization.wantConfirmDeletionTask,
                                cancelText: localization.cancel,
                                confirmText: localization.delete,
                                onConfirm: () {
                                  //todo
                                });
                          },
                          title: Text(
                            task.title,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList();

              if (state.tasks.isNotEmpty) {
                return BoardView(
                  boardViewController: boardViewController,
                  lists: boardLists,
                );
              } else {
                return StateWidget(isLoading: false, localization.createTask);
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
