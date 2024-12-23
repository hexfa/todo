import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo/domain/entities/task_data_request.dart';

part 'task_data_request.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskDataRequest extends TaskDataEntityRequest {
  final String? content;
  final String? description;
  @JsonKey(name: 'due_datetime')
  final String? startDate;
  @JsonKey(name: 'due_date')
  final String? deadLine;
  final int? priority;
  @JsonKey(name: 'project_id')
  final String? projectId;
  @JsonKey(name: 'due_string')
  final String? startTimer;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'duration_unit')
  final String? durationUnit;

  const TaskDataRequest(
      {required this.content,
      required this.description,
      required this.startDate,
      required this.deadLine,
      required this.priority,
      required this.projectId,
      required this.startTimer,
      required this.duration,
      required this.durationUnit})
      : super(
          content: content,
          description: description,
          startDate: startDate,
          deadLine: deadLine,
          priority: priority,
          projectId: projectId,
        );

  factory TaskDataRequest.fromJson(Map<String, dynamic> json) =>
      _$TaskDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDataRequestToJson(this);
}
