import 'package:dartz/dartz.dart';
import 'package:todo/data/models/comment_data_request.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/comments_repository.dart';
import '../datasources/comments_remote_datasource.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource remoteDataSource;

  CommentsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Comment>>> getComments(String taskId) async {
    try {
      final comments = await remoteDataSource.getComments(taskId);
      return Right(comments.map((t) => t.toEntity()).toList());
    } catch (e) {
      print('comments error is $e');

      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> createComment(
      CommentDataRequest comment) async {
    try {
      final result = await remoteDataSource.createComment(comment);
      return Right(result.toEntity());
    } catch (e) {
      print('comments error is $e');

      return Left(ServerFailure(message: e.toString()));
    }
  }
}
