import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';
import 'package:todo/domain/usecases/update_task_usecase.dart';

import 'update_task_usecase_test.mocks.dart';

@GenerateMocks([TasksRepository])
void main() {
  late UpdateTaskUseCase useCase;
  late MockTasksRepository mockTasksRepository;

  setUp(() {
    mockTasksRepository = MockTasksRepository();
    useCase = UpdateTaskUseCase(mockTasksRepository);
  });

  const tId = "2995104339";
  const tTaskDataRequest = TaskDataRequest(content: "Buy Coffee",dueString: "tomorrow at 12:00", dueLang: "en", priority: "4", project_id: '2345233582');
  const tTaskEntity = TaskEntity(
    creatorId: "12345",
    createdAt: "2023-10-01T12:34:56Z",
    assigneeId: "54321",
    assignerId: null,
    commentCount: 5,
    isCompleted: false,
    description: "This is a test task",
    due: null,
    duration: "1h",
    id: "1",
    labels: ["label1", "label2"],
    order: 1,
    priority: 4,
    projectId: "proj_1",
    sectionId: "sec_1",
    parentId: null,
    url: "https://todoist.com/showTask?id=1",
    title: 'test',
    state: '',
  );

  group('UpdateTaskUseCase Tests', () {
    test(
      'should call repository.updateTask with correct parameters and return TaskEntity on success',
          () async {
        // Arrange
        when(mockTasksRepository.updateTask(tTaskDataRequest, tId))
            .thenAnswer((_) async => Right(tTaskEntity));

        // Act
        final result = await useCase(UpdateTaskParams(id: tId, taskData: tTaskDataRequest));

        // Assert
        verify(mockTasksRepository.updateTask(tTaskDataRequest, tId));
        expect(result, Right(tTaskEntity));
        verifyNoMoreInteractions(mockTasksRepository);
      },
    );

    test(
      'should return ServerFailure when repository.updateTask fails',
          () async {
        // Arrange
        when(mockTasksRepository.updateTask(tTaskDataRequest, tId))
            .thenAnswer((_) async => Left(ServerFailure(message: "Failed to update task")));

        // Act
        final result = await useCase(UpdateTaskParams(id: tId, taskData: tTaskDataRequest));

        // Assert
        verify(mockTasksRepository.updateTask(tTaskDataRequest, tId));
        expect(result, Left(ServerFailure(message: "Failed to update task")));
        verifyNoMoreInteractions(mockTasksRepository);
      },
    );

    test(
      'should return ServerFailure when repository.updateTask throws an exception',
          () async {
        // Arrange
        when(mockTasksRepository.updateTask(any, any))
            .thenThrow(Exception("Unexpected error"));

        // Act
        final result = await useCase(UpdateTaskParams(id: tId, taskData: tTaskDataRequest));

        // Assert
        expect(result, Left(ServerFailure(message: 'Exception: Unexpected error')));
        verify(mockTasksRepository.updateTask(any, any));
      },
    );


  });
}
