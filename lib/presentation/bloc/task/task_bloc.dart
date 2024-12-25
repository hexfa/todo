import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/section.dart';
import 'package:todo/domain/usecases/delete_task_usecase.dart';
import 'package:todo/domain/usecases/get_tasks_usecase.dart';
import 'package:todo/domain/usecases/update_task_usecase.dart';
import 'package:todo/presentation/bloc/task/task_event.dart';
import 'package:todo/presentation/bloc/task/task_state.dart';
import 'package:todo/presentation/views/task_state.dart';

final sectionResult = [
  Section(id: '1', name: TaskState.todo.name),
  Section(id: '2', name: TaskState.inProgress.name),
  Section(id: '3', name: TaskState.done.name),
];

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasksUseCase getTasksUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TasksBloc({
    required this.getTasksUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TasksInitial()) {
    on<FetchTasksEvent>((event, emit) async {
      emit(TasksLoading());
      final result =
          await getTasksUseCase.call(TasksParams(event.projectId ?? ''));

      result.fold(
        (failure) => emit(TasksError(failure.message)),
        (tasks) {
          emit(TasksLoaded(tasks, sectionResult));
        },
      );
    });

    on<UpdateFetchTasksEvent>((event, emit) async {
      final result =
          await getTasksUseCase.call(TasksParams(event.projectId ?? ''));

      result.fold(
        (failure) => emit(TasksError(failure.message)),
        (tasks) => emit(TasksLoaded(tasks, sectionResult)),
      );
    });

    on<UpdateTaskEvent>((event, emit) async {
      int tempDuration = event.task.duration == null || event.task.duration == 0
          ? 1
          : event.task.duration! ~/ 60;
      event.task.duration = tempDuration == 0 ? 1 : tempDuration;
      final result = await updateTaskUseCase.call(UpdateTaskParams(
        id: event.taskId ?? '',
        taskData: event.task,
      ));
      result.fold(
        (failure) => emit(TasksError(failure.message)),
        (task) {
          add(UpdateFetchTasksEvent(event.task.projectId));
        },
      );
    });

    on<DeleteEvent>((event, emit) async {
      final result = await deleteTaskUseCase.call(event.taskId ?? '');
      result.fold(
        (failure) => emit(TasksError(failure.message)),
        (task) {
          add(UpdateFetchTasksEvent(event.projectId));
        },
      );
    });
  }
}
