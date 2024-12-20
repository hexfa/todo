import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/util/date_time_convert.dart';
import 'package:todo/data/models/due_model.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/domain/entities/comment.dart';
import 'package:todo/domain/usecases/update_task_usecase.dart';
import 'package:todo/presentation/bloc/update_task/update_task_event.dart';
import 'package:todo/presentation/bloc/update_task/update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  late TaskModelResponse currentTask;
  final UpdateTaskUseCase updateTaskUseCase;

  UpdateTaskBloc({required this.updateTaskUseCase})
      : super(TaskInitializeState()) {
    on<CreateCommentEvent>(_onCreateCommentEvent);
    on<StartTimer>(_onStartTimer);
    on<StopTimer>(_onStopTimer);
    on<FinishTimer>(_onFinishTimer);
    on<ConfirmUpdateTask>(_onConfirmUpdateTask);
  }

  Future<void> _onConfirmUpdateTask(
      ConfirmUpdateTask event, Emitter emit) async {
    emit(UpdateTaskLoadingState());
    final result = await updateTaskUseCase.call(UpdateTaskParams(
      id: event.task.id,
      taskData: TaskDataRequest(
          content: event.task.content,
          description: event.task.description,
          deadLine: event.task.due?.date,
          priority: event.task.priority.toString(),
          projectId: event.task.projectId),
    ));
    result.fold(
        (failure) => emit(UpdateTaskErrorState(failure.message)),
        (task) => emit(
              ConfirmUpdateTaskState(),
            ));
  }

  void _onCreateCommentEvent(CreateCommentEvent event, Emitter emit) {
    //create comment in server
    currentTask.addComment(Comment(event.comment));
    emit(UpdateTask(currentTask));
  }

  void _onStartTimer(StartTimer event, Emitter emit) {
    currentTask.due ??= DueModel(
        date: '',
        datetime: '',
        isRrecurring: false,
        startTimer: '',
        timezone: '');
    currentTask.isRunning = true;
    currentTask.due?.startTimer = DateTimeConvert.getCurrentDate();
    //update task
    emit(UpdateTask(currentTask));
  }

  void _onStopTimer(StopTimer event, Emitter emit) {
    currentTask.isRunning = false;
    currentTask.duration = event.second.toString();
    currentTask.due!.startTimer = '';
    //update task
    emit(UpdateTask(currentTask));
  }

  void _onFinishTimer(FinishTimer event, Emitter emit) {
    currentTask.isRunning = false;
    currentTask.duration =
        calculateDifferenceInSeconds(currentTask.due!.startTimer).toString();
    currentTask.due?.startTimer = '';
    //update task
  }

  int calculateDifferenceInSeconds(String stopTime) {
    try {
      final DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ");
      final DateTime parsedTime = format.parse(stopTime);
      final DateTime currentTime = DateTime.now();
      final Duration difference = currentTime.difference(parsedTime);
      return difference.inSeconds;
    } catch (e) {
      print("Error parsing date: $e");
      return 0;
    }
  }

  void startTimerFrom(int initialSeconds) {
    int elapsedSeconds = initialSeconds;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedSeconds++;
    });
  }

  int dateTimeStringToSeconds(String dateString) {
    DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSZ").parse(dateString);

    return dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  }
}
