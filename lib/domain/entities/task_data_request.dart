import 'package:equatable/equatable.dart';

class TaskDataEntityRequest extends Equatable{
  final String? content;
  final String? dueString;
  final String? dueLang;
  final String? priority;

  const TaskDataEntityRequest({
    required this.content,
    required this.dueString,
    required this.dueLang,
    required this.priority
});
  @override
  List<Object?> get props => [
    content,
    dueString,
    dueLang,
    priority
  ];
}