part of 'comment_bloc.dart';

abstract class CommentState extends StateBase {
  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentFailed extends CommentState {
  final String message;

  CommentFailed({required this.message});

  @override
  List<Object> get props => [message];
}

final class CreateCommentSuccess extends CommentState {
  final Comment comment;

  CreateCommentSuccess({required this.comment});

  @override
  List<Object> get props => [comment];
}

final class CommentsLoaded extends CommentState {
  final List<Comment> comments;

  CommentsLoaded({required this.comments});

  @override
  List<Object> get props => [comments];
}
