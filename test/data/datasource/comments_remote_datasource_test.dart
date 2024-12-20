import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/comments_remote_datasource_impl.dart';
import 'package:todo/data/models/attachment_model.dart';
import 'package:todo/data/models/comment_model.dart';
import 'package:todo/services/api/project_service.dart';


import 'comments_remote_datasource_test.mocks.dart';

@GenerateMocks([ProjectService])
void main() {
  late MockProjectService mockProjectService;
  late CommentsRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockProjectService = MockProjectService();
    remoteDataSource = CommentsRemoteDataSourceImpl(mockProjectService);
  });

  group('CommentsRemoteDataSourceImpl Tests', () {
    const String tTaskId = "2995104339";

    final List<CommentModel> tComments = [
      CommentModel(
        id: "2992679862",
        content: "Need one bottle of milk",
        postedAt: "2016-09-22T07:00:00.000000Z",
        projectId: null,
        taskId: "2995104339",
        attachment: AttachmentModel(
          fileName: "File.pdf",
          fileType: "application/pdf",
          fileUrl: "https://cdn-domain.tld/path/to/file.pdf",
          resourceType: "file",
        ),
      )
    ];

    test(
      'should return list of CommentModel when ProjectService.getComments is called successfully',
      () async {
        // Arrange
        when(mockProjectService.getAllComments(tTaskId))
            .thenAnswer((_) async => tComments);

        // Act
        final result = await remoteDataSource.getComments(tTaskId);

        // Assert
        verify(mockProjectService.getAllComments(tTaskId));
        expect(result, tComments);
        verifyNoMoreInteractions(mockProjectService);
      },
    );

    test(
      'should throw ServerFailure when ProjectService.getComments throws an exception',
      () async {
        // Arrange
        when(mockProjectService.getAllComments(tTaskId))
            .thenThrow(Exception("Unexpected error"));

        // Act
        final call = remoteDataSource.getComments;

        // Assert
        expect(
            () => call(tTaskId),
            throwsA(isA<ServerFailure>().having(
                (f) => f.message, 'message', 'Failed to fetch comment')));
        verify(mockProjectService.getAllComments(tTaskId));
        verifyNoMoreInteractions(mockProjectService);
      },
    );
  });
}
