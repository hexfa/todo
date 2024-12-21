import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/domain/entities/section.dart';
import 'package:todo/domain/usecases/delete_task_usecase.dart';
import 'package:todo/domain/usecases/get_tasks_usecase.dart';
import 'package:todo/domain/usecases/update_task_usecase.dart';
import 'package:todo/presentation/bloc/task/task_event.dart';
import 'package:todo/presentation/bloc/task/task_state.dart';

final sectionResult = [
  const Section(id: '1', name: 'todo'),
  const Section(id: '2', name: 'inProgress'),
  const Section(id: '3', name: 'done'),
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
      final result = await getTasksUseCase.call(TasksParams(event.projectId??''));

      result.fold(
        (failure) => emit(TasksError(failure.message)),
        (tasks) => emit(TasksLoaded(tasks,sectionResult)),
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
      final result = await updateTaskUseCase.call(UpdateTaskParams(
        id: event.taskId ?? '',
        taskData: TaskDataRequest(
          content: event.content,
          dueString: null,
          dueLang: null,
          priority: event.priority,
          project_id: event.projectId,
        ),
      ));
      result.fold(
        (failure) => emit(TasksError(failure.message)),
        (task) {
          add(UpdateFetchTasksEvent(event.projectId));
        },
      );
    });

    on<DeleteEvent>((event, emit) async {
      final result = await deleteTaskUseCase.call(event.taskId??'');
      result.fold(
        (failure) => emit(TasksError(failure.message)),
        (task) {
          add(UpdateFetchTasksEvent(event.projectId));
        },
      );
    });
  }
}
