//comment_data_request

import 'package:json_annotation/json_annotation.dart';
import 'package:todo/data/models/attachment_model.dart';
import 'package:todo/domain/entities/comment_request.dart';
part 'comment_data_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentDataRequest extends CommentDataEntityRequest {
  final String? content;
  @JsonKey(name: 'task_id')
  final String? taskId;
  @JsonKey(name: 'project_id')
  final String? projectId;
  @JsonKey(name: 'attachment')
  final AttachmentModel? attachment;

   CommentDataRequest({
    required this.content,
    required this.projectId,
    required this.taskId,
    required this.attachment,
  }) : super(
            attachment: attachment,
            content: content,
            projectId: projectId,
            taskId: taskId);

  factory CommentDataRequest.fromJson(Map<String, dynamic> json) =>
      _$CommentDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDataRequestToJson(this);
}
