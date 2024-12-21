import 'package:dartz/dartz.dart';
import 'package:todo/data/models/comment_data_request.dart';
import '../../core/error/failure.dart';
import '../entities/comment.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<Comment>>> getComments(String taskId);

  Future<Either<Failure, Comment>> createComment(CommentDataRequest comment);
}
