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
      return Right(comments);
    } catch (e) {
      print('-----------------catch:${e.toString()}');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> createComment(
      CommentDataRequest comment) async {
    try {
      final result = await remoteDataSource.createComment(comment);
      return Right(result);
    } catch (e) {
      print('-----------------catch');
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
