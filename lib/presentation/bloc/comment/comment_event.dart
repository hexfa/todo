part of 'comment_bloc.dart';

abstract class CommentEvent extends EventBase {
  @override
  List<Object> get props => [];
}

final class FetchCommentsEvent extends CommentEvent {
  final String projectId;
  final String taskId;

  FetchCommentsEvent({required this.projectId, required this.taskId});

  @override
  List<Object> get props => [projectId, taskId];
}

class CreateCommentEvent extends CommentEvent {
  final String projectId;
  final String taskId;
  final String content;

  CreateCommentEvent(
      {required this.projectId, required this.taskId, required this.content});
}
