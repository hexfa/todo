import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/tasks_remote_datasource_impl.dart';
import 'package:todo/data/models/due_model.dart';
import 'package:todo/data/models/task_data_request.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/services/api/project_service.dart';

import 'tasks_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProjectService])
void main() {
  late TasksRemoteDataSourceImpl dataSource;
  late MockProjectService mockProjectService;

  setUp(() {
    mockProjectService = MockProjectService();
    dataSource = TasksRemoteDataSourceImpl(service: mockProjectService);
  });

  group('getTasks', () {
    const tTaskModelResponse = TaskModelResponse(
      creatorId: "12345",
      createdAt: "2023-10-01T12:34:56Z",
      assigneeId: "54321",
      assignerId: null,
      commentCount: 5,
      isCompleted: false,
      content: "Test Task",
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
    );

    final tTaskList = [tTaskModelResponse];

    test(
        'should return list of TaskModelResponse when the call to ProjectService is successful',
        () async {
      // Arrange
      when(mockProjectService.getTasks()).thenAnswer((_) async => tTaskList);

      // Act
      final result = await dataSource.getTasks();

      // Assert
      expect(result, equals(tTaskList));
      verify(mockProjectService.getTasks());
      verifyNoMoreInteractions(mockProjectService);
    });
  });

  test(
      'should throw ServerFailure when the call to ProjectService throws an exception',
          () async {
        // Arrange
        when(mockProjectService.getTasks()).thenThrow(Exception());

        // Act
        final call = dataSource.getTasks;

        // Assert
        expect(() => call(), throwsA(isA<ServerFailure>()));
        verify(mockProjectService.getTasks());
        verifyNoMoreInteractions(mockProjectService);
      });

  test(
      'should return empty list when ProjectService returns an empty list',
          () async {
        // Arrange
        when(mockProjectService.getTasks()).thenAnswer((_) async => []);

        // Act
        final result = await dataSource.getTasks();

        // Assert
        expect(result, equals([]));
        verify(mockProjectService.getTasks());
        verifyNoMoreInteractions(mockProjectService);
      });

  group('createTask', () {
    const tContent = "Buy Milk";
    const tDueString = "tomorrow at 12:00";
    const tDueLang = "en";
    const tPriority = "4"; // Changed to String as per your base class
    const tTaskDataRequest = TaskDataRequest(
      content: tContent,
      dueString: tDueString,
      dueLang: tDueLang,
      priority: tPriority,
    );
    const tTaskModelResponse = TaskModelResponse(
      creatorId: "2671355",
      createdAt: "2019-12-11T22:36:50.000000Z",
      assigneeId: null,
      assignerId: null,
      commentCount: 0,
      isCompleted: false,
      content: tContent,
      description: "",
      due: DueModel(
        date: "2024-12-19",
        isRrecurring: false,
        datetime: "2024-12-19T12:00:00.000000Z",
        string: tDueString,
        timezone: "Europe/Moscow",
      ),
      duration: null,
      id: "2995104339",
      labels: [],
      order: 1,
      priority: 4,
      projectId: "2203306141",
      sectionId: null,
      parentId: null,
      url: "https://todoist.com/showTask?id=2995104339",
    );

    test('should return TaskModelResponse when the call to service is successful',
            () async {
          // Arrange
          when(mockProjectService.createTask(any))
              .thenAnswer((_) async => tTaskModelResponse);

          // Act
          final result = await dataSource.createTask(tTaskDataRequest);

          // Assert
          expect(result, tTaskModelResponse);
          verify(mockProjectService.createTask(tTaskDataRequest));
          verifyNoMoreInteractions(mockProjectService);
        });

    test(
        'should throw ServerFailure when the call to service throws an exception',
            () async {
          // Arrange
          when(mockProjectService.createTask(any)).thenThrow(Exception());

          // Act
          final call = dataSource.createTask(tTaskDataRequest);

          // Assert
          expect(() => call, throwsA(isA<ServerFailure>()));
          verify(mockProjectService.createTask(tTaskDataRequest));
          verifyNoMoreInteractions(mockProjectService);
        });
  });


  group('deleteTask', () {
    const tId = "2995104339";

    test('should return true when the call to service is successful', () async {
      // Arrange
      when(mockProjectService.deleteTask(tId))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await dataSource.deleteTask(tId);

      // Assert
      expect(result, true);
      verify(mockProjectService.deleteTask(tId));
      verifyNoMoreInteractions(mockProjectService);
    });

    test(
        'should throw ServerFailure when the call to service throws an exception',
            () async {
          // Arrange
          when(mockProjectService.deleteTask(tId))
              .thenThrow(Exception());

          // Act
          final call = dataSource.deleteTask(tId);

          // Assert
          expect(() => call, throwsA(isA<ServerFailure>()));
          verify(mockProjectService.deleteTask(tId));
          verifyNoMoreInteractions(mockProjectService);
        });
  });
}
