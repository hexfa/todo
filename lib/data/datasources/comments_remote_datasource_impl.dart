import 'package:todo/data/models/comment_data_request.dart';

import '../../core/error/failure.dart';
import '../../services/api/project_service.dart';
import '../models/comment_model.dart';
import 'comments_remote_datasource.dart';

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final ProjectService service;

  CommentsRemoteDataSourceImpl(this.service);

  @override
  Future<List<CommentModel>> getComments(String taskId) async {
    try {
      return await service.getAllComments(taskId);
    } catch (e) {
      throw ServerFailure(message: 'Failed to fetch comment ${e.toString()}');
    }
  }

  @override
  Future<CommentModel> createComment(CommentDataRequest comment) async {
    try {
      return await service.createComment(comment);
    } catch (e) {
      throw const ServerFailure(message: 'Failed to create comment');
    }
  }
}
