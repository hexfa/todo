import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/bloc/base/event_base.dart';
import 'package:todo/presentation/bloc/base/state_base.dart';

part 'create_task_event.dart';

part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc() : super(AddTaskInitial()) {
    on<AddEvent>(_onAddEvent);
    on<InitialDataEvent>(_onInitialDataEvent);
  }

  void _onAddEvent(AddEvent event, Emitter state) {
    //create in server
    emit(AddSuccessState());
  }

  void _onInitialDataEvent(InitialDataEvent event, Emitter state) {
    emit(InitialDataState(
        ['Todo', 'In Progress', 'Done'],
        //get project list
        [],
        ['Low', 'Medium', 'High'],
        [1, 2, 3, 4, 5]));
  }
}
