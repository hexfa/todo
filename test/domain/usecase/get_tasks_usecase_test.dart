import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';
import 'package:todo/domain/usecases/get_tasks_usecase.dart';

import 'get_tasks_usecase_test.mocks.dart';

@GenerateMocks([TasksRepository])
void main() {
  late GetTasksUseCase useCase;
  late MockTasksRepository mockTasksRepository;

  setUp(() {
    mockTasksRepository = MockTasksRepository();
    useCase = GetTasksUseCase(mockTasksRepository);
  });

  group('GetTasksUseCase', () {
    const tTaskEntity = TaskEntity(
      creatorId: "12345",
      createdAt: "2023-10-01T12:34:56Z",
      assigneeId: "54321",
      assignerId: null,
      commentCount: 5,
      isCompleted: false,
      description: "This is a test task",
      due: null,
      // durationChange: "1h",
      id: "1",
      labels: ["label1", "label2"],
      order: 1,
      priority: 4,
      projectId: "proj_1",
      sectionId: "sec_1",
      parentId: null,
      url: "https://todoist.com/showTask?id=1",
      content: 'test',
    );

    final List<TaskEntity> tTaskList = [tTaskEntity];

    test(
        'should return Right<List<TaskEntity>> when the call to repository is successful',
        () async {
      // Arrange
      when(mockTasksRepository.getTasks('2345233582'))
          .thenAnswer((_) async => Right(tTaskList));

      // Act
      final result = await useCase.call(TasksParams('2345233582'));

      // Assert
      expect(result, Right(tTaskList));
      verify(mockTasksRepository.getTasks('2345233582'));
      verifyNoMoreInteractions(mockTasksRepository);
    });

    test(
        'should return Left(ServerFailure) when the call to repository fails with ServerFailure',
        () async {
      // Arrange
      when(mockTasksRepository.getTasks('2345233582')).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server Error')));

      // Act
      final result = await useCase.call(TasksParams('2345233582'));

      // Assert
      expect(result, const Left(ServerFailure(message: 'Server Error')));
      verify(mockTasksRepository.getTasks('2345233582'));
      verifyNoMoreInteractions(mockTasksRepository);
    });

    test(
        'should return Left(ServerFailure) when the repository returns a ServerFailure',
        () async {
      // Arrange
      when(mockTasksRepository.getTasks('2345233582')).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Unexpected Error')));

      // Act
      final result = await useCase.call(TasksParams('2345233582'));

      // Assert
      expect(result, const Left(ServerFailure(message: 'Unexpected Error')));
      verify(mockTasksRepository.getTasks('2345233582'));
      verifyNoMoreInteractions(mockTasksRepository);
    });
  });
}
