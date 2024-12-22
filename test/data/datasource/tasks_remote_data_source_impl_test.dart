import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/remote/tasks_remote_datasource.dart';
import 'package:todo/data/models/due_model.dart';
import 'package:todo/data/models/duration_model.dart';
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
    var tTaskModelResponse = TaskModelResponse(
      creatorId: "12345",
      createdAt: "2023-10-01T12:34:56Z",
      assigneeId: "54321",
      assignerId: null,
      commentCount: 5,
      isCompleted: false,
      content: "Test Task",
      description: "This is a test task",
      due: null,
      duration: DurationModel(amount: 1,unit: "unit"),
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
      when(mockProjectService.getTasks('2345233582'))
          .thenAnswer((_) async => tTaskList);

      // Act
      final result = await dataSource.getTasks(projectId: '2345233582');

      // Assert
      expect(result, equals(tTaskList));
      verify(mockProjectService.getTasks('1'));
      verifyNoMoreInteractions(mockProjectService);
    });
  });

  test(
      'should throw ServerFailure when the call to ProjectService throws an exception',
      () async {
    // Arrange
    when(mockProjectService.getTasks('2345233582')).thenThrow(Exception());

    // Act
    final call = dataSource.getTasks;

    // Assert
    expect(() => call(projectId: '2345233582'), throwsA(isA<ServerFailure>()));
    verify(mockProjectService.getTasks('2345233582'));
    verifyNoMoreInteractions(mockProjectService);
  });

  test('should return empty list when ProjectService returns an empty list',
      () async {
    // Arrange
    when(mockProjectService.getTasks('2345233582')).thenAnswer((_) async => []);

    // Act
    final result = await dataSource.getTasks(projectId: '2345233582');

    // Assert
    expect(result, equals([]));
    verify(mockProjectService.getTasks('2345233582'));
    verifyNoMoreInteractions(mockProjectService);
  });

  group('createTask', () {
    const tContent = "Buy Milk";
    const tDescription = "Description of by milk";
    const tDeadLine = "2024-09-10";
    const tPriority = "4"; // Changed to String as per your base class
    const tProjectId = "123343";
    const tDuration = 1;
    const tDurationUnit = "minute";
    const tStartTimer = "2024-09-10";
    var tTaskDataRequest = const TaskDataRequest(
        content: tContent,
        description: tDescription,
        deadLine: tDeadLine,
        priority: tPriority,
        projectId: tProjectId,
        startTimer: tStartTimer,
        duration: tDuration,
        durationUnit: tDurationUnit);
    var tTaskModelResponse = TaskModelResponse(
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
        isRecurring: false,
        datetime: "2024-12-19T12:00:00.000000Z",
        string: "2024-12-19",
        timezone: "Europe/Moscow",
      ),
      // durationChange: null,
      id: "2995104339",
      labels: [],
      order: 1,
      priority: 4,
      projectId: "2203306141",
      sectionId: null,
      parentId: null,
      url: "https://todoist.com/showTask?id=2995104339",
    );

    test(
        'should return TaskModelResponse when the call to service is successful',
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
      when(mockProjectService.deleteTask(tId)).thenThrow(Exception());

      // Act
      final call = dataSource.deleteTask(tId);

      // Assert
      expect(() => call, throwsA(isA<ServerFailure>()));
      verify(mockProjectService.deleteTask(tId));
      verifyNoMoreInteractions(mockProjectService);
    });
  });
}
