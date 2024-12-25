import 'package:equatable/equatable.dart';
import 'attachment.dart';

class Comment extends Equatable {
  final String id;
  final String content;
  final String postedAt;
  final String? projectId;
  final String? taskId;
  final Attachment? attachment;

  const Comment({
    required this.id,
    required this.content,
    required this.postedAt,
    this.projectId,
    this.taskId,
    required this.attachment,
  });

  @override
  List<Object?> get props =>
      [id, content, postedAt, projectId, taskId, attachment];
}
