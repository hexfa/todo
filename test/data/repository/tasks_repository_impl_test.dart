import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/local/sync_local_datasource.dart';
import 'package:todo/data/datasources/local/tasks_local_datasource.dart';
import 'package:todo/data/datasources/remote/tasks_remote_datasource.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/domain/entities/task.dart';

import 'tasks_repository_impl_test.mocks.dart';

@GenerateMocks([
  TasksRemoteDataSource,
  TasksLocalDataSource,
  SyncLocalDataSource,
])
void main() {
  late TasksRepositoryImpl repository;
  late MockTasksRemoteDataSource mockRemoteDataSource;
  late MockTasksLocalDataSource mockLocalDataSource;
  late MockSyncLocalDataSource mockSyncQueue;

  setUp(() {
    mockRemoteDataSource = MockTasksRemoteDataSource();
    mockLocalDataSource = MockTasksLocalDataSource();
    mockSyncQueue = MockSyncLocalDataSource();
    repository = TasksRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      syncQueue: mockSyncQueue,
    );
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
      id: "1",
      labels: ["label1", "label2"],
      order: 1,
      priority: 4,
      projectId: "proj_1",
      sectionId: "sec_1",
      parentId: null,
      url: "https://todoist.com/showTask?id=1",
    );

    final List<TaskModelResponse> tTaskModelList = [tTaskModelResponse];
    final List<TaskEntity> tTaskEntityList = [tTaskModelResponse.toEntity()];

    test(
        'should return Right<List<TaskEntity>> when local data source has tasks',
            () async {
          // Arrange
          when(mockLocalDataSource.getTasks(projectId: '2345233582'))
              .thenAnswer((_) async => tTaskModelList);

          // Act
          final result = await repository.getTasks('2345233582');

          // Assert
          expect(result.isRight(), true);
          result.fold(
                (failure) => fail('Expected Right but got Left'),
                (tasks) {
              expect(tasks, equals(tTaskEntityList));
            },
          );
          verify(mockLocalDataSource.getTasks(projectId: '2345233582')).called(1);
          verifyZeroInteractions(mockRemoteDataSource);
          verifyZeroInteractions(mockSyncQueue);
          verifyNoMoreInteractions(mockLocalDataSource);
        });

    test(
        'should return Right<List<TaskEntity>> when local data source is empty and remote call is successful',
            () async {
          // Arrange
          when(mockLocalDataSource.getTasks(projectId: '2345233582'))
              .thenAnswer((_) async => []);
          when(mockRemoteDataSource.getTasks(projectId: '2345233582'))
              .thenAnswer((_) async => tTaskModelList);
          when(mockLocalDataSource.saveTasks(tTaskModelList))
              .thenAnswer((_) async => Future.value());

          // Act
          final result = await repository.getTasks('2345233582');

          // Assert
          expect(result.isRight(), true);
          result.fold(
                (failure) => fail('Expected Right but got Left'),
                (tasks) {
              expect(tasks, equals(tTaskEntityList));
            },
          );
          verify(mockLocalDataSource.getTasks(projectId: '2345233582')).called(1);
          verify(mockRemoteDataSource.getTasks(projectId: '2345233582')).called(1);
          verify(mockLocalDataSource.saveTasks(tTaskModelList)).called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
          verifyNoMoreInteractions(mockLocalDataSource);
          verifyZeroInteractions(mockSyncQueue);
        });

    test(
        'should return Left(ServerFailure) when remote data source throws ServerFailure',
            () async {
          // Arrange
          when(mockLocalDataSource.getTasks(projectId: '2345233582'))
              .thenAnswer((_) async => []);
          when(mockRemoteDataSource.getTasks(projectId: '2345233582'))
              .thenThrow(ServerFailure(message: 'Server Error'));

          // Act
          final result = await repository.getTasks('2345233582');

          // Assert
          expect(result.isLeft(), true);
          result.fold(
                (failure) {
              expect(failure, isA<ServerFailure>());
              expect((failure as ServerFailure).message, 'Server Error');
            },
                (_) => fail('Expected Left but got Right'),
          );
          verify(mockLocalDataSource.getTasks(projectId: '2345233582')).called(1);
          verify(mockRemoteDataSource.getTasks(projectId: '2345233582')).called(1);
          verifyNever(mockLocalDataSource.saveTasks(any));
          verifyNoMoreInteractions(mockRemoteDataSource);
          verifyNoMoreInteractions(mockLocalDataSource);
          verifyZeroInteractions(mockSyncQueue);
        });

    test(
        'should return Left(ServerFailure) when remote data source throws a generic exception',
            () async {
          // Arrange
          when(mockLocalDataSource.getTasks(projectId: '2345233582'))
              .thenAnswer((_) async => []);
          when(mockRemoteDataSource.getTasks(projectId: '2345233582'))
              .thenThrow(Exception('Some generic error'));

          // Act
          final result = await repository.getTasks('2345233582');

          // Assert
          expect(result.isLeft(), true);
          result.fold(
                (failure) {
              expect(failure, isA<ServerFailure>());
              expect((failure as ServerFailure).message,
                  'Unexpected Error Exception: Some generic error');
            },
                (_) => fail('Expected Left but got Right'),
          );
          verify(mockLocalDataSource.getTasks(projectId: '2345233582')).called(1);
          verify(mockRemoteDataSource.getTasks(projectId: '2345233582')).called(1);
          verifyNever(mockLocalDataSource.saveTasks(any));
          verifyNoMoreInteractions(mockRemoteDataSource);
          verifyNoMoreInteractions(mockLocalDataSource);
          verifyZeroInteractions(mockSyncQueue);
        });

    test(
        'should return Right(empty list) when remote data source returns an empty list and save it locally',
            () async {
          // Arrange
          when(mockLocalDataSource.getTasks(projectId: '2345233582'))
              .thenAnswer((_) async => []);
          when(mockRemoteDataSource.getTasks(projectId: '2345233582'))
              .thenAnswer((_) async => []);
          when(mockLocalDataSource.saveTasks([]))
              .thenAnswer((_) async => Future.value());

          // Act
          final result = await repository.getTasks('2345233582');

          // Assert
          expect(result.isRight(), true);
          result.fold(
                (failure) => fail('Expected Right but got Left'),
                (tasks) {
              expect(tasks, equals(<TaskEntity>[]));
            },
          );
          verify(mockLocalDataSource.getTasks(projectId: '2345233582')).called(1);
          verify(mockRemoteDataSource.getTasks(projectId: '2345233582')).called(1);
          verify(mockLocalDataSource.saveTasks([])).called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
          verifyNoMoreInteractions(mockLocalDataSource);
          verifyZeroInteractions(mockSyncQueue);
        });
  });
}
