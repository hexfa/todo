import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/bloc/base/state_base.dart';

abstract class UpdateTaskState extends StateBase{
  @override
  List<Object> get props => [];
}

class TaskInitializeState extends UpdateTaskState{}

class UpdateTaskLoadingState extends UpdateTaskState{}

class UpdateTaskErrorState extends UpdateTaskState{
  final String message;

  UpdateTaskErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ConfirmUpdateTaskState extends UpdateTaskState{}

class UpdateTask extends UpdateTaskState {
  final TaskModelResponse task;
  final DateTime timestamp;

  UpdateTask(this.task) : timestamp = DateTime.now();

  @override
  List<Object> get props => [task, timestamp];
}

// class TimerState {
//   final bool isRunning;
//   final int elapsedSeconds;
//
//   const TimerState({
//     required this.isRunning,
//     required this.elapsedSeconds,
//   });
//
//   // محاسبه ساعت، دقیقه و ثانیه از مجموع ثانیه‌ها
//   String get formattedTime {
//     final hours = (elapsedSeconds ~/ 3600).toString().padLeft(2, '0');
//     final minutes = ((elapsedSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
//     final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
//     return '$hours:$minutes:$seconds';
//   }
//
//   TimerState copyWith({bool? isRunning, int? elapsedSeconds}) {
//     return TimerState(
//       isRunning: isRunning ?? this.isRunning,
//       elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
//     );
//   }
// }
