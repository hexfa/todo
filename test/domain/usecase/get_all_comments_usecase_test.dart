import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/data/models/attachment_model.dart';
import 'package:todo/domain/entities/attachment.dart';
import 'package:todo/domain/entities/comment.dart';
import 'package:todo/domain/repositories/comments_repository.dart';
import 'package:todo/domain/usecases/get_all_comments_usecase.dart';
import 'get_all_comments_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CommentsRepository>()])

void main() {
  late GetAllCommentsUseCase useCase;
  late MockCommentsRepository mockRepository;

  setUp(() {
    mockRepository = MockCommentsRepository();
    useCase = GetAllCommentsUseCase(mockRepository);
  });

  test('should fetch comments for a given task ID', () async {
    // Arrange
    final taskId = "2995104339";
    final comments = [
      Comment(
        id: "2992679862",
        content: "Need one bottle of milk",
        postedAt: "2016-09-22T07:00:00.000000Z",
        projectId: null,
        taskId: taskId,
        attachment: Attachment(
          fileName: "File.pdf",
          fileType: "application/pdf",
          fileUrl: "https://cdn-domain.tld/path/to/file.pdf",
          resourceType: "file",
        ),
      )
    ];
    when(mockRepository.getComments(taskId))
        .thenAnswer((_) async => Right(comments));

    // Act
    final result = await useCase(taskId);

    // Assert
    expect(result, Right(comments));
    verify(mockRepository.getComments(taskId));
  });
}
