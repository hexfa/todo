import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/comment_data_request.dart';
import 'package:todo/domain/entities/comment.dart';
import 'package:todo/domain/usecases/create_comments_usecase.dart';
import 'package:todo/domain/usecases/get_all_comments_usecase.dart';
import 'package:todo/presentation/bloc/base/event_base.dart';
import 'package:todo/presentation/bloc/base/state_base.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetAllCommentsUseCase getAllCommentsUseCase;
  final CreateCommentUseCase createCommentUseCase;

  CommentBloc(
      {required this.getAllCommentsUseCase, required this.createCommentUseCase})
      : super(CommentInitial()) {
    on<FetchCommentsEvent>(_onFetchCommentsEvent);
    on<CreateCommentEvent>(_onCreateCommentEvent);
  }

  Future<void> _onFetchCommentsEvent(
      FetchCommentsEvent event, Emitter emit) async {
    emit(CommentLoading());
    final result = await getAllCommentsUseCase(event.taskId);
    result.fold(
      (failure) => emit(CommentFailed(message: 'Failed to fetch comment')),
      (comments) => emit(CommentsLoaded(comments: comments)),
    );
  }

  Future<void> _onCreateCommentEvent(
      CreateCommentEvent event, Emitter emit) async {
    emit(CommentLoading());
    final result = await createCommentUseCase(CommentDataRequest(
        content: event.content,
        projectId: event.projectId,
        taskId: event.taskId,
        attachment: null));
    result.fold(
      (failure) => emit(CommentFailed(message: 'Failed to create comment')),
      (comments) => emit(CreateCommentSuccess(comment: comments)),
    );
  }
}
