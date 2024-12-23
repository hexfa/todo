import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/util/date_time_convert.dart';
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
  final List<String> _priorityList = ['todo', 'inProgress', 'done'];
  String? _selectPriority;
  TaskModelResponse? task;
  List<Comment> comments = [];


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
        if (state is CreateCommentSuccess) {
          context.read<CommentBloc>().add(
              FetchCommentsEvent(projectId: '', taskId: widget.taskId));
        }
      },
      child: BlocConsumer<UpdateTaskBloc, UpdateTaskState>(
        listener: (context, state) {
          if (state is ConfirmUpdateTaskState) {
            router.pop();
          }
          if(state is UpdateTaskErrorState){
            context.read<UpdateTaskBloc>().add(FetchTask(taskId: widget.taskId));

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
            switch (task!.priority) {
              case 2:
                _selectPriority = 'inProgress';
                break;
              case 3:
                _selectPriority = 'done';
                break;
              default:
                _selectPriority = 'todo';
                break;
            }

            if (task!.priority != 3) {
              if (task != null &&
                  task!.due?.string != null &&
                  task!.due!.string!.isNotEmpty &&
                  DateTimeConvert.calculateSecondsDifference(task!.due!.string!) >
                      0) {

              }
            }
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
                          context.read<UpdateTaskBloc>().add(ConfirmUpdateTask(
                              id: task!.id,
                              content: _contentController.text,
                              description: _descriptionController.text,
                              priority: getSelectPriority(),
                              deadLine: task!.due?.date ?? '',
                              startTimer: getSelectPriority() == 3
                                  ? DateTimeConvert.getCurrentDate()
                                  : task!.due?.string ?? '',
                              duration: sumDurations(),
                              projectId: task!.projectId));
                        }
                      },
                      icon: const Icon(Icons.check))
                ],
              ),
              body: state is UpdateTaskLoadingState
                  ? StateWidget(null, isLoading: true)
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
                    CustomDropdown<String>(
                      selectedValue: _selectPriority,
                      items: _priorityList,
                      hintText: localization.selectATaskState,
                      onValueChanged: (newValue) {
                        _selectPriority = newValue;
                      },
                    ),
                    const SizedBox(height: 16),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: TimerWidget(
                            isStartTimer: task != null &&
                                task!.due?.string != null &&
                                task!.due!.string!.isNotEmpty &&
                                DateTimeConvert.calculateSecondsDifference(task!.due!.string!) >
                                    0,
                            onStartChanged: startTimerChange,
                            onStopChanged: stopTimerChange,
                            sumDurations: sumDurations)
                    ),                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        TextField(
                          controller: _commentController,
                          maxLines: 5,
                          minLines: 5,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'post comment ...',
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
                                      content: _commentController.text,
                                      projectId: task!.projectId,
                                      taskId: task!.id));
                              _commentController.text = '';
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Comments',
                          style: theme.textTheme.titleLarge?.copyWith(
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
  void stopTimerChange() {
    context.read<UpdateTaskBloc>().add(ChangeTimer(
        id: task!.id,
        content: task!.content,
        description: task!.description,
        priority: task!.priority,
        deadLine: task!.due?.date ?? '',
        startTimer: '',
        duration: ((task!.duration?.amount ?? 1) * 60) +
            DateTimeConvert.calculateSecondsDifference(task!.due?.string ?? ''),
        projectId: task!.projectId));
    task!.due?.string = '';
  }

  void startTimerChange() {
    String startTimer = DateTimeConvert.getCurrentDate();
    context.read<UpdateTaskBloc>().add(ChangeTimer(
        id: task!.id,
        content: task!.content,
        description: task!.description,
        priority: task!.priority,
        deadLine: task!.due?.date ?? '',
        startTimer: startTimer,
        duration: (task!.duration?.amount ?? 1) * 60,
        projectId: task!.projectId));
    task!.due?.string = startTimer;
  }

  int getSelectPriority() {
    switch (_selectPriority) {
      case 'inProgress':
        return 2;
      case 'done':
        return 3;
      default:
        return 1;
    }
  }
}
