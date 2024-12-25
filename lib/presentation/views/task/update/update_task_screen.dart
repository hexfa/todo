import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/domain/entities/comment.dart';
import 'package:todo/presentation/bloc/comment/comment_bloc.dart';
import 'package:todo/presentation/bloc/update_task/update_task_bloc.dart';
import 'package:todo/presentation/bloc/update_task/update_task_event.dart';
import 'package:todo/presentation/bloc/update_task/update_task_state.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/custom_view/custom_dropdown_button.dart';
import 'package:todo/presentation/views/custom_view/custom_multiline_text_field.dart';
import 'package:todo/presentation/views/custom_view/custom_normal_text_field.dart';
import 'package:todo/presentation/views/state_widget.dart';
import 'package:todo/presentation/views/task_state.dart';
import 'package:todo/presentation/views/timer_widget.dart';

class UpdateTaskScreen extends StatefulWidget {
  final String taskId;

  const UpdateTaskScreen({super.key, required this.taskId});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends BaseState<UpdateTaskScreen> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<TaskState> _priorityList = TaskStateUtils.values;
  TaskState? _selectPriority;
  TaskModelResponse? task;
  List<Comment> comments = [];
  String tempTimer = '';

  int sumDurations() {
    int diff = task!.due?.string == null
        ? 0
        : DateTimeConvert.calculateSecondsDifference(task!.due!.string!);
    int duration = (task?.duration != null ? task!.duration!.amount : 0) * 60;
    return task!.priority == 3 ? duration : diff + duration;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is CommentsLoaded) {
          setState(() {
            comments = state.comments;
          });
        }
        if (state is FetchCommentFailed) {
          context
              .read<CommentBloc>()
              .add(FetchCommentsEvent(projectId: '', taskId: widget.taskId));
        }
        if (state is CommentFailed) {
          context.read<CommentBloc>().add(CreateCommentEvent(
              content: _commentController.text,
              projectId: task!.projectId,
              taskId: task!.id));
        }
        if (state is CreateCommentSuccess) {
          _commentController.text = '';

          context
              .read<CommentBloc>()
              .add(FetchCommentsEvent(projectId: '', taskId: widget.taskId));
        }
      },
      child: BlocConsumer<UpdateTaskBloc, UpdateTaskState>(
        listener: (context, state) {
          if (state is ConfirmUpdateTaskState) {
            router.pop();
          }
          if (state is TaskErrorState) {
            context
                .read<UpdateTaskBloc>()
                .add(FetchTask(taskId: widget.taskId));
          }
          if (state is UpdateTaskErrorState) {
            _confirmUpdate(context);
          }
        },
        builder: (context, state) {
          if (state is UpdateTask) {
            task = state.task;
          }

          if (state is TaskLoadedState) {
            task = state.task;

            _contentController.text = task!.content;
            _descriptionController.text = task!.description;
            _selectPriority =
                TaskStateExtension.fromServerValue(task!.priority);
          }
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (bool didPop, Object? result) {
              refreshNotifier = true;
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: theme.colorScheme.primary,
                title: Text(
                  localization.updateTask,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.colorScheme.onPrimary),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (task != null) {
                          _confirmUpdate(context);
                        }
                      },
                      icon: const Icon(Icons.check))
                ],
              ),
              body: state is UpdateTaskLoadingState
                  ? const StateWidget(null, isLoading: true)
                  : task == null
                      ? Container()
                      : SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              CustomNormalTextField(
                                  controller: _contentController,
                                  labelText: localization.content),
                              const SizedBox(height: 20),
                              CustomMultiLineTextField(
                                  controller: _descriptionController,
                                  labelText: localization.description,
                                  countLine: 3),
                              const SizedBox(height: 20),
                              CustomDropdown<TaskState>(
                                selectedValue: _selectPriority,
                                items: _priorityList,
                                hintText: localization.selectATaskState,
                                onValueChanged: (newValue) {
                                  _selectPriority = newValue;
                                },
                                itemBuilder: (TaskState state) {
                                  return Text(state.name);
                                },
                              ),
                              const SizedBox(height: 16),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: TimerWidget(
                                    isStartTimer: task != null &&
                                        task!.priority != 3 &&
                                        task!.due?.string != null &&
                                        task!.due!.string!.isNotEmpty &&
                                        DateTimeConvert
                                                .calculateSecondsDifference(
                                                    task!.due!.string!) >
                                            0,
                                    isShowControlButton: task!.priority != 3,
                                    onStartChanged: startTimerChange,
                                    onStopChanged: stopTimerChange,
                                    sumDurations: sumDurations,
                                  )),
                              const SizedBox(height: 20),
                              Stack(
                                children: [
                                  TextField(
                                    controller: _commentController,
                                    maxLines: 5,
                                    minLines: 5,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText:
                                          '${localization.postComment} ...',
                                      alignLabelWithHint: true,
                                    ),
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  Positioned(
                                    right: 10,
                                    bottom: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<CommentBloc>().add(
                                            CreateCommentEvent(
                                                content:
                                                    _commentController.text,
                                                projectId: task!.projectId,
                                                taskId: task!.id));
                                      },
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (comments.isNotEmpty)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(localization.comments,
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                              color: theme.colorScheme.primary,
                                              fontWeight: FontWeight.bold)),
                                ),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(comments[index].content),
                                        trailing: Text(
                                            DateTimeConvert.wrapDateToString(
                                                comments[index].postedAt),
                                            style: theme.textTheme.labelMedium
                                                ?.copyWith(color: Colors.grey)),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
            ),
          );
        },
      ),
    );
  }

  void _confirmUpdate(BuildContext context) {
    //handle timer
    tempTimer = '';
    if (_selectPriority!.serverValue != 3 && task!.priority == 3) {
      tempTimer = '';
    } else if (_selectPriority!.serverValue == 3) {
      tempTimer = DateTimeConvert.getCurrentDate();
    } else {
      tempTimer = task!.due?.string ?? '';
    }

    context.read<UpdateTaskBloc>().add(ConfirmUpdateTask(
          id: task!.id,
          task: TaskDataRequest(
              content: _contentController.text,
              description: _descriptionController.text,
              startDate: task!.due?.datetime ?? '',
              deadLine: task!.due?.date ?? '',
              priority: _selectPriority!.serverValue,
              projectId: task!.projectId,
              startTimer: tempTimer,
              duration: sumDurations(),
              durationUnit: 'minute'),
        ));
  }

  void stopTimerChange() {
    int updateDuration = ((task!.duration?.amount ?? 1) * 60) +
        DateTimeConvert.calculateSecondsDifference(task!.due?.string ?? '');
    context.read<UpdateTaskBloc>().add(ChangeTimer(
          id: task!.id,
          task: TaskDataRequest(
              content: task!.content,
              description: task!.description,
              startDate: task!.due?.datetime ?? '',
              deadLine: task!.due?.date ?? '',
              priority: task!.priority,
              projectId: task!.projectId,
              startTimer: '',
              duration: updateDuration,
              durationUnit: 'minute'),
        ));
    task!.due?.string = '';
    task!.duration?.amount = updateDuration ~/ 60;
  }

  void startTimerChange() {
    String startTimer = DateTimeConvert.getCurrentDate();
    context.read<UpdateTaskBloc>().add(ChangeTimer(
        id: task!.id,
        task: TaskDataRequest(
            content: task!.content,
            description: task!.description,
            startDate: task!.due?.datetime ?? '',
            deadLine: task!.due?.date ?? '',
            priority: task!.priority,
            projectId: task!.projectId,
            startTimer: startTimer,
            duration: (task!.duration?.amount ?? 1) * 60,
            durationUnit: 'minute')));
    task!.due?.string = startTimer;
  }
}
