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
  TaskModelResponse? task;

  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    task = context.read<UpdateTaskBloc>().currentTask;

    if (task != null && task!.isRunning) {
      _seconds = task?.duration != null ? int.parse(task!.duration!) : 0;
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

  String _formatSecondsToTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$remainingSeconds';
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

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (task != null && task!.isRunning && !_isRunning) {
              _seconds =
                  task?.duration != null ? int.parse(task!.duration!) : 0;
              _startTimer();
            } else if (task != null && !task!.isRunning && _isRunning) {
              _stopTimer();
            }
          });
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
                      context
                          .read<UpdateTaskBloc>()
                          .add(ConfirmUpdateTask(task!));
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          task?.content ?? 'No Content',
                          style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    //description
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 5 * 24.0,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            task?.description ?? 'description',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: theme.colorScheme.onSurface),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          if (_isRunning) {
                            context
                                .read<UpdateTaskBloc>()
                                .add(StopTimer(_seconds));
                          } else {
                            context.read<UpdateTaskBloc>().add(StartTimer());
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
                        '${_formatSecondsToTime(_seconds)}',
                        style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 16),
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
}
