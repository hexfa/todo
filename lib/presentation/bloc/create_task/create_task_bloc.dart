import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/domain/entities/task_data_request.dart';
import 'package:todo/domain/usecases/create_task_usecase.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';
import 'package:todo/presentation/bloc/base/event_base.dart';
import 'package:todo/presentation/bloc/base/state_base.dart';

part 'create_task_event.dart';

part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final GetProjectsUseCase getProjectsUseCase;
  final CreateTaskUseCase createTaskUseCase;

  CreateTaskBloc(
      {required this.getProjectsUseCase, required this.createTaskUseCase})
      : super(CreateTaskInitial()) {
    on<ConfirmCreateTaskEvent>(_onConfirmCreateTaskEvent);
  }

  Future<void> _onConfirmCreateTaskEvent(
      ConfirmCreateTaskEvent event, Emitter state) async {
    emit(CreateTaskLoadingState());
    final result = await createTaskUseCase(TaskDataRequest(
      content: event.task.content,
      description: event.task.description,
      startDate: event.task.startDate,
      deadLine: event.task.deadLine,
      priority: event.task.priority,
      projectId: event.task.projectId,
      startTimer: '',
      duration: 1,
      durationUnit: 'minute',
    ));
    result.fold(
      (failure) => emit(CreateTaskFailedState('Failed to create task')),
      (projects) => emit(CreateTaskSuccessState()),
    );
  }
}
