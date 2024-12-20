import '../../core/error/failure.dart';
import '../../services/api/project_service.dart';
import '../models/comment_model.dart';
import 'comments_remote_datasource.dart';

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final ProjectService service;

  CommentsRemoteDataSourceImpl(this.service
      );

  @override
  Future<List<CommentModel>> getComments(String taskId) async {
    try {
      return await service.getAllComments(taskId);
    } catch (e) {
      throw const ServerFailure(message: 'Failed to fetch comment');
    }
  }
}
