import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/due_model.dart';
import 'package:todo/data/models/duration_model.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/domain/usecases/get_task_usecase.dart';
import 'package:todo/domain/usecases/update_task_usecase.dart';
import 'package:todo/presentation/bloc/update_task/update_task_event.dart';
import 'package:todo/presentation/bloc/update_task/update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  final UpdateTaskUseCase updateTaskUseCase;
  final GetTaskUseCase getTaskUseCase;

  UpdateTaskBloc(
      {required this.updateTaskUseCase, required this.getTaskUseCase})
      : super(TaskInitializeState()) {
    on<ChangeTimer>(_onChangeTimer);
    on<ConfirmUpdateTask>(_onConfirmUpdateTask);
    on<FetchTask>(_onFetchTask);
  }

  Future<void> _onConfirmUpdateTask(
      ConfirmUpdateTask event, Emitter emit) async {
    int tempDuration = event.duration == 0 ? 1 : event.duration ~/ 60;
    emit(UpdateTaskLoadingState());
    final result = await updateTaskUseCase.call(UpdateTaskParams(
      id: event.id,
      taskData: TaskDataRequest(
          content: event.content,
          description: event.description,
          startDate: event.startDate,
          deadLine: event.deadLine,
          priority: event.priority,
          projectId: event.projectId,
          duration: tempDuration == 0 ? 1 : tempDuration,
          startTimer: event.startTimer,
          durationUnit: 'minute'),
    ));
    result.fold(
        (failure) => emit(UpdateTaskErrorState(failure.message)),
        (task) => emit(
              ConfirmUpdateTaskState(),
            ));
  }

  Future<void> _onFetchTask(FetchTask event, Emitter emit) async {
    emit(UpdateTaskLoadingState());
    final result = await getTaskUseCase.call(event.taskId);
    result.fold(
        (failure) => emit(TaskErrorState(failure.message)),
        (task) => emit(TaskLoadedState(
            task: TaskModelResponse(
                duration: DurationModel(
                    amount: task.duration == null ? 1 : task.duration!.amount,
                    unit: 'minute'),
                due: DueModel(
                    date: task.due?.date ?? '',
                    isRecurring: task.due?.isRecurring ?? false,
                    datetime: task.due?.datetime ?? '',
                    string: task.due?.string ?? '',
                    timezone: task.due?.timezone ?? ''),
                creatorId: task.creatorId,
                createdAt: task.createdAt,
                commentCount: task.commentCount,
                isCompleted: task.isCompleted,
                content: task.content,
                description: task.description,
                id: task.id,
                labels: task.labels,
                order: task.order,
                priority: task.priority,
                projectId: task.projectId,
                url: task.url))));
  }

  Future<void> _onChangeTimer(ChangeTimer event, Emitter emit) async {
    int tempDuration = event.duration ~/ 60;
    await updateTaskUseCase.call(UpdateTaskParams(
      id: event.id,
      taskData: TaskDataRequest(
          content: event.content,
          description: event.description,
          startDate: event.startDate,
          deadLine: event.deadLine,
          priority: event.priority,
          projectId: event.projectId,
          duration: tempDuration == 0 ? 1 : tempDuration,
          startTimer: event.startTimer,
          durationUnit: 'minute'),
    ));
  }
}
