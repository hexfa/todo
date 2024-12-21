import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/comment.dart';
import 'attachment_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Comment {
  final String id;
  final String content;
  @JsonKey(name: 'posted_at')

  final String postedAt;
  @JsonKey(name: 'project_id')

  final String? projectId;
  @JsonKey(name: 'task_id')

  final String? taskId;
  final AttachmentModel attachment;
  CommentModel({
    required this.id,
    required this.content,
    required this.postedAt,
    required this.projectId,
    required this.taskId,
    required this.attachment
  }) : super(
    id: id,
    content: content,
    postedAt: postedAt,
    projectId: projectId,
    taskId: taskId,
    attachment: attachment,
  );

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}


