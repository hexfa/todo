import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<ChangeTimer>(_onChangeTimer);
    on<ConfirmUpdateTask>(_onConfirmUpdateTask);
  }

  Future<void> _onConfirmUpdateTask(
      ConfirmUpdateTask event, Emitter emit) async {
    emit(UpdateTaskLoadingState());
    final result = await updateTaskUseCase.call(UpdateTaskParams(
      id: event.id,
      taskData: TaskDataRequest(
          content: event.content,
          description: event.description,
          deadLine: event.deadLine,
          priority: event.priority.toString(),
          projectId: event.projectId,
          duration: event.duration,
          startTimer: event.startTimer,
          durationUnit: 'minute'),
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

  Future<void> _onChangeTimer(ChangeTimer event, Emitter emit) async {
    await updateTaskUseCase.call(UpdateTaskParams(
      id: event.id,
      taskData: TaskDataRequest(
          content: event.content,
          description: event.description,
          deadLine: event.deadLine,
          priority: event.priority.toString(),
          projectId: event.projectId,
          duration: event.duration ~/ 60,
          startTimer: event.startTimer.isEmpty ? null : event.startTimer,
          durationUnit: 'minute'),
    ));
  }
}
