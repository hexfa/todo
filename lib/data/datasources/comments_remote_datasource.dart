import 'package:todo/data/models/comment_data_request.dart';

import '../models/comment_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getComments(String taskId);

  Future<CommentModel> createComment(CommentDataRequest comment);
}
