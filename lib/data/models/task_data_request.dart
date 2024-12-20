import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo/domain/entities/task_data_request.dart';

part 'task_data_request.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskDataRequest extends TaskDataEntityRequest {
  final String? content;
  @JsonKey(name: 'due_string')
  final String? dueString;
  @JsonKey(name: 'due_lang')
  final String? dueLang;
  final String? priority;
  final String? project_id;


  const TaskDataRequest({required this.content,
    required this.dueString,
    required this.dueLang,
    required this.project_id,
    required this.priority}) :super(content: content,
      dueString: dueString,
      dueLang: dueLang,
      priority: priority);

  factory TaskDataRequest.fromJson(Map<String, dynamic> json) =>
      _$TaskDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDataRequestToJson(this);

}