class Task {
  final String title;
  final String description;
  final String state;
  final String priority;
  final String project;
  final String point;
  final DateTime createDate = DateTime.now();
  final DateTime? startDate;
  final DateTime? endDate;
  int commentCount = 0;
  bool isRunning;
  int durationWork;

  Task(this.title, this.description, this.state, this.priority, this.project,
      this.point, this.startDate, this.endDate,
      {this.isRunning = false, this.durationWork = 0});

  String get formattedTime {
    final hours = (durationWork ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((durationWork % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (durationWork % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}
