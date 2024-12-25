enum TaskState {
  todo,
  inProgress,
  done,
}

extension TaskStateUtils on TaskState {
  static List<TaskState> get values => TaskState.values;
}

extension TaskStateExtension on TaskState {
  int get serverValue {
    switch (this) {
      case TaskState.todo:
        return 1;
      case TaskState.inProgress:
        return 2;
      case TaskState.done:
        return 3;
    }
  }

  // String get displayName {
  //   switch (this) {
  //     case TaskState.todo:
  //       return "To Do";
  //     case TaskState.inProgress:
  //       return "In Progress";
  //     case TaskState.done:
  //       return "Done";
  //   }
  // }

  static TaskState fromServerValue(int value) {
    switch (value) {
      case 1:
        return TaskState.todo;
      case 2:
        return TaskState.inProgress;
      case 3:
        return TaskState.done;
      default:
        throw Exception("Invalid server value for TaskState: $value");
    }
  }
}
