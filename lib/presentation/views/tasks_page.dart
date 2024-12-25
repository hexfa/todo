import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/bloc/task/task_bloc.dart';
import 'package:todo/presentation/bloc/task/task_event.dart';
import 'package:todo/presentation/bloc/task/task_state.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/state_widget.dart';
import 'package:todo/presentation/views/task_tile.dart';

class TasksPage extends StatefulWidget {
  final String projectId;

  const TasksPage({super.key, required this.projectId});

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
    if (refreshNotifier) {
      refreshNotifier = false;
      context.read<TasksBloc>().add(FetchTasksEvent(widget.projectId));
    }

    return Scaffold(
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
              router.push(AppRoutePath.createTaskRoute);
            },
          ),
        ],
      ),
      body: BlocConsumer<TasksBloc, TasksState>(
        listener: (context, state) {
          if (state is TasksError) {
            context.read<TasksBloc>().add(FetchTasksEvent(widget.projectId));
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
                        BoardItemState state) {
                      int priority = 1;
                      if (oldListIndex == 0) {
                        priority = 1;
                      } else if (oldListIndex == 1) {
                        priority = 2;
                      } else if (oldListIndex == 2) {
                        priority = 3;
                      }

                      updateTask(priority, task, context);
                    },
                    item: GestureDetector(
                      onTap: () {
                        router
                            .push('${AppRoutePath.updateTaskRoute}/${task.id}');
                      },
                      child: TaskTile(
                          task: task,
                          onDeleteConfirm: () {
                            context
                                .read<TasksBloc>()
                                .add(DeleteEvent(task.id, widget.projectId));
                          }),
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
    );
  }

  void updateTask(int priority, TaskEntity task, BuildContext context) {
    //handle timer
    String tempTimer = '';
    if (priority != 3 && task.priority == 3) {
      tempTimer = '';
    } else if (priority == 3) {
      tempTimer = DateTimeConvert.getCurrentDate();
    } else {
      tempTimer = task.due?.string ?? '';
    }

    //duration
    int tempDuration = 1;
    int diff = task.due?.string == null
        ? 0
        : DateTimeConvert.calculateSecondsDifference(task.due!.string!);
    int duration = (task.duration != null ? task.duration!.amount : 0) * 60;
    tempDuration = task.priority == 3 ? duration : diff + duration;

    context.read<TasksBloc>().add(UpdateTaskEvent(
        task.id,
        TaskDataRequest(
            content: task.content,
            description: task.description,
            projectId: widget.projectId,
            priority: priority,
            startDate: task.due?.datetime ?? '',
            deadLine: task.due?.date ?? '',
            startTimer: tempTimer,
            duration: tempDuration,
            durationUnit: 'minute')));
  }
}
