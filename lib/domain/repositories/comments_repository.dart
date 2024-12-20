import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/comment.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<Comment>>> getComments(String taskId);
}
