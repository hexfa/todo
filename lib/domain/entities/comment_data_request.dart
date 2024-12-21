import 'package:equatable/equatable.dart';
import 'package:todo/data/models/attachment_model.dart';

class CommentDataEntityRequest extends Equatable {
  final String? content;
  final String? taskId;
  final String? projectId;
  final AttachmentModel? attachment;

  const CommentDataEntityRequest(
      {required this.content,
      required this.taskId,
      required this.projectId,
      required this.attachment});

  @override
  List<Object?> get props => [content, taskId, projectId, attachment];
}
