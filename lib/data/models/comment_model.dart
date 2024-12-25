import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/comment.dart';
import 'attachment_model.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 5) // Set a unique typeId for Hive
@JsonSerializable()
class CommentModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  @JsonKey(name: 'posted_at')
  final String postedAt;

  @HiveField(3)
  @JsonKey(name: 'project_id')
  final String? projectId;

  @HiveField(4)
  @JsonKey(name: 'task_id')
  final String? taskId;

  @HiveField(5)
  final AttachmentModel? attachment;

  CommentModel({
    required this.id,
    required this.content,
    required this.postedAt,
    this.projectId,
    this.taskId,
    this.attachment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  Comment toEntity() {
    return Comment(
      id: id,
      content: content,
      postedAt: postedAt,
      projectId: projectId,
      taskId: taskId,
      attachment: attachment?.toEntity(),
    );
  }
}
