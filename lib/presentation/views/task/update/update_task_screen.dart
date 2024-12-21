import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/di.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/domain/entities/comment.dart';
import 'package:todo/presentation/bloc/comment/comment_bloc.dart';
import 'package:todo/presentation/bloc/update_task/update_task_bloc.dart';
import 'package:todo/presentation/bloc/update_task/update_task_event.dart';
import 'package:todo/presentation/bloc/update_task/update_task_state.dart';
import 'package:todo/presentation/views/base/base-state.dart';
import 'package:todo/presentation/views/custom_view/custom_dropdown_button.dart';
import 'package:todo/presentation/views/custom_view/custom_multiline_text_field.dart';
import 'package:todo/presentation/views/custom_view/custom_normal_text_field.dart';
import 'package:todo/presentation/views/state_widget.dart';

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

  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _isRunning = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _isRunning = false;
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateTaskBloc, UpdateTaskState>(
      listener: (context, state) {
        print('-------------------۹۵}');
        if (state is ConfirmUpdateTaskState) {
          navigator.pop();
        }
      },
      builder: (context, state) {
        if (state is UpdateTask) {
          task = state.task;
        }

        if (state is TaskLoadedState) {
          print('-------------------105 ${state.task.due}');
          task = state.task;

          //init data
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

          //show timer
          if (task != null &&
              task!.due?.datetime != null &&
              task!.due!.datetime.isNotEmpty) {
            int diff =
                DateTimeConvert.calculateSecondsDifference(task!.due!.datetime);
            int duration =
                (task?.duration != null ? task!.commentCount : 0) * 60;
            _seconds = diff + duration;
            _startTimer();
          }
        }

        return Scaffold(
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
                          startTimer: task!.due?.datetime ?? '',
                          duration: 1,
                          // duration: task!.durationChange != null? int.parse(task!.durationChange!) : 0,
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
                  : Container(
                      color: theme.colorScheme.surface,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 8),
                            //content
                            CustomNormalTextField(
                                controller: _contentController,
                                labelText: localization.content),
                            const SizedBox(height: 20),
                            CustomMultiLineTextField(
                                controller: _descriptionController,
                                labelText: localization.description,
                                countLine: 3),
                            SizedBox(height: 20),
                            //priority
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (_isRunning) {
                                        context.read<UpdateTaskBloc>().add(
                                            ChangeTimer(
                                                id: task!.id,
                                                content: task!.content,
                                                description: task!.description,
                                                priority: task!.priority,
                                                deadLine: task!.due?.date ?? '',
                                                startTimer: '',
                                                duration: ((task!.duration
                                                                ?.amount ??
                                                            1) *
                                                        60) +
                                                    DateTimeConvert
                                                        .calculateSecondsDifference(
                                                            task!.due
                                                                    ?.datetime ??
                                                                ''),
                                                projectId: task!.projectId));
                                        _stopTimer();
                                      } else {
                                        context.read<UpdateTaskBloc>().add(
                                            ChangeTimer(
                                                id: task!.id,
                                                content: task!.content,
                                                description: task!.description,
                                                priority: task!.priority,
                                                deadLine: task!.due?.date ?? '',
                                                startTimer: DateTimeConvert
                                                    .getCurrentDate(),
                                                duration:
                                                    (task!.duration?.amount ??
                                                            1) *
                                                        60,
                                                projectId: task!.projectId));
                                        _startTimer();
                                      }
                                    },
                                    child: Text(
                                      _isRunning
                                          ? '${localization.stop} :'
                                          : '${localization.start} :',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                              color: _isRunning
                                                  ? theme.colorScheme.error
                                                  : Colors.green,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    DateTimeConvert.formatSecondsToTime(
                                        _seconds),
                                    style: theme.textTheme.labelLarge?.copyWith(
                                        color: theme.colorScheme.onSurface,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            //comment
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
                                  scrollPadding: const EdgeInsets.all(20),
                                  scrollPhysics: BouncingScrollPhysics(),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      getBloc<UpdateTaskBloc>(context).add(
                                          CreateCommentEvent(
                                              _commentController.text));
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
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Comments',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Flexible(
                              child: ListView.builder(
                                  itemCount: task!.commentList.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                          '' /*task!.commentList[index].comment*/),
                                      // trailing: Text(
                                      //     DateTimeConvert.convertDateToString(task!.commentList[index].dateCreated)),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
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
