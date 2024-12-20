import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/usecases/create_task_usecase.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';
import 'package:todo/domain/usecases/no_param.dart';
import 'package:todo/presentation/bloc/base/event_base.dart';
import 'package:todo/presentation/bloc/base/state_base.dart';

part 'create_task_event.dart';

part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final GetProjectsUseCase getProjectsUseCase;
  final CreateTaskUseCase createTaskUseCase;

  CreateTaskBloc(
      {required this.getProjectsUseCase, required this.createTaskUseCase})
      : super(AddTaskInitial()) {
    on<AddEvent>(_onAddEvent);
    on<InitialDataEvent>(_onInitialDataEvent);
  }

  Future<void> _onAddEvent(AddEvent event, Emitter state) async {
    emit(CreateTaskLoadingState());
    final result = await createTaskUseCase(TaskDataRequest(
        content: event.task.content,
        description: event.task.description,
        deadLine: event.task.due?.date,
        priority: event.task.priority.toString(),
        projectId: event.task.projectId));
    result.fold(
      (failure) => emit(CreateTaskFailedState('Failed to create task')),
      (projects) => emit(AddSuccessState()),
    );
  }

  Future<void> _onInitialDataEvent(
      InitialDataEvent event, Emitter state) async {
    emit(CreateTaskLoadingState());
    final result = await getProjectsUseCase(NoParams());
    result.fold(
      (failure) => emit(CreateTaskFailedState('Failed to load projects')),
      (projects) => emit(InitialDataState(projects)),
    );
  }
}
