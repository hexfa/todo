import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/section.dart';
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
      final sectionResult=[
        Section(id: '1', name: 'todo'),
/*
        Section(id: '2',  name: 'inProgress'),
*/
        Section(id: '3', name: 'inProgress'),
        Section(id: '4', name: 'done'),
      ];
      print(result);
      result.fold(
        (failure) => emit(TasksError(failure.message)),
        (tasks) => emit(TasksLoaded(tasks,sectionResult)),
      );
    });
  }
}
