import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/usecases/get_tasks_usecase.dart';
import 'package:todo/presentation/bloc/task/task_event.dart';
import 'package:todo/presentation/bloc/task/task_state.dart';

import '../../../domain/usecases/no_param.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasksUseCase getTasksUseCase;

  TasksBloc({required this.getTasksUseCase}) : super(TasksInitial()) {
    on<FetchTasksEvent>((event, emit) async {
      emit(TasksLoading());
      final result = await getTasksUseCase.call(TasksParams(event.projectId??''));
      print(result);
      result.fold(
        (failure) => emit(TasksError(failure.message)),
        (tasks) => emit(TasksLoaded(tasks)),
      );
    });
  }
}
