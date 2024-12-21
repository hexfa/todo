import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/presentation/bloc/update_task/update_task_bloc.dart';
import 'package:todo/presentation/bloc/update_task/update_task_event.dart';
import 'package:todo/presentation/bloc/update_task/update_task_state.dart';
import 'package:todo/presentation/views/base/base-state.dart';
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

  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    task = context
        .read<UpdateTaskBloc>()
        .currentTask;
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
    if (task != null && task!.due?.datetime != null &&
        task!.due!.datetime.isNotEmpty) {
      int diff = DateTimeConvert.calculateSecondsDifference(
          task!.due!.datetime);
      int duration = /*(task?.duration != null ? task!.commentCount : 0)  * 60 */ 0;
      _seconds = diff + duration;
      _startTimer();
    }
  }

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
        if (state is ConfirmUpdateTaskState) {
          navigator.pop();
        }
      },
      builder: (context, state) {
        if (state is UpdateTask) {
          task = state.task;
        }

        if (state is UpdateTaskLoadingState) {
          return StateWidget(isLoading: true, null);
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.colorScheme.primary,
              title: Text(
                'Task',
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.onPrimary),
              ),
              actions: [
                IconButton(
                    onPressed: () {
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
                    },
                    icon: Icon(Icons.check))
              ],
            ),
            body: Container(
              color: theme.colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //content
                    TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration:
                      const InputDecoration(labelText: 'Description'),
                    ),
                    // priority
                    DropdownButton<String>(
                        value: _selectPriority,
                        items: _priorityList.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text('$option'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectPriority = newValue;
                          });
                        },
                        isExpanded: true),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          if (_isRunning) {
                            context.read<UpdateTaskBloc>().add(ChangeTimer(
                                id: task!.id,
                                content: task!.content,
                                description: task!.description,
                                priority: task!.priority,
                                deadLine: task!.due?.date ?? '',
                                startTimer: '',
                                duration: /*(task.duration * 60) + */ DateTimeConvert
                                    .calculateSecondsDifference(
                                    task!.due?.datetime ?? ''),
                                projectId: task!.projectId
                            ));
                            _stopTimer();
                          } else {
                            context.read<UpdateTaskBloc>().add(ChangeTimer(
                                id: task!.id,
                                content: task!.content,
                                description: task!.description,
                                priority: task!.priority,
                                deadLine: task!.due?.date ?? '',
                                startTimer: DateTimeConvert.getCurrentDate(),
                                duration: /*task.duration * 60 + */ 1,
                                projectId: task!.projectId
                            ));
                            _startTimer();
                          }
                        },
                        child: Text(
                          _isRunning ? 'Stop' : 'Start',
                          style: theme.textTheme.titleSmall?.copyWith(
                              color: _isRunning
                                  ? theme.colorScheme.error
                                  : Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${DateTimeConvert.formatSecondsToTime(_seconds)}',
                        style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 16),
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
                          style: TextStyle(fontSize: 16),
                          scrollPadding: EdgeInsets.all(20),
                          scrollPhysics: BouncingScrollPhysics(),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: GestureDetector(
                            onTap: () {
                              getBloc<UpdateTaskBloc>(context).add(
                                  CreateCommentEvent(_commentController.text));
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
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Comments',
                          style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: task!.commentList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(task!.commentList[index].comment),
                              trailing: Text(
                                  DateTimeConvert.convertDateToString(
                                      task!.commentList[index].dateCreated)),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
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
