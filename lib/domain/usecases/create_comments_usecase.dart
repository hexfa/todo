import 'package:dartz/dartz.dart';
import 'package:todo/data/models/comment_data_request.dart';
import '../../core/error/failure.dart';
import '../entities/comment.dart';
import '../repositories/comments_repository.dart';
import 'base_usecase.dart';

class CreateCommentUseCase implements UseCase<Comment, CommentDataRequest> {
  final CommentsRepository repository;

  CreateCommentUseCase(this.repository);

  @override
  Future<Either<Failure, Comment>> call(CommentDataRequest comment) async {
    return await repository.createComment(comment);
  }
}
