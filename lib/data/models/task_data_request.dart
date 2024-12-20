import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo/domain/entities/task_data_request.dart';

part 'task_data_request.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskDataRequest extends TaskDataEntityRequest {
  final String? content;
  final String? description;
  @JsonKey(name: 'due_date')
  final String? deadLine;
  final String? priority;
  @JsonKey(name: 'project_id')
  final String? projectId;

  const TaskDataRequest({
    required this.content,
    required this.description,
    required this.deadLine,
    required this.priority,
    required this.projectId,
  }) : super(
            content: content,
            description: description,
            deadLine: deadLine,
            priority: priority,
            projectId: projectId);

  factory TaskDataRequest.fromJson(Map<String, dynamic> json) =>
      _$TaskDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDataRequestToJson(this);
}
