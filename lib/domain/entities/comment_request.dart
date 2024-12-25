import 'package:todo/data/models/attachment_model.dart';

class CommentDataEntityRequest {
  final String? content;
  final String? taskId;
  final String? projectId;
  final AttachmentModel? attachment;

  CommentDataEntityRequest({
    required this.content,
    this.projectId,
    this.taskId,
    required this.attachment,
  });

  @override
  List<Object?> get props => [content, projectId, taskId, attachment];
}
