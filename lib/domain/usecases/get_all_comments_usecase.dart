import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/comment.dart';
import '../repositories/comments_repository.dart';
import 'base_usecase.dart';

class GetAllCommentsUseCase implements UseCase<List<Comment>, String> {
  final CommentsRepository repository;

  GetAllCommentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Comment>>> call(String taskId) async {
    return await repository.getComments(taskId);
  }
}
