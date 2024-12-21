import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/remote/tasks_remote_datasource.dart';
import 'package:todo/data/models/task_model_response.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/domain/entities/task.dart';

import 'tasks_repository_impl_test.mocks.dart';

@GenerateMocks([TasksRemoteDataSource])
void main() {
  late TasksRepositoryImpl repository;
  late MockTasksRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTasksRemoteDataSource();
    repository = TasksRepositoryImpl(remoteDataSource: mockRemoteDataSource, localDataSource: null, syncQueue: null);
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

    final List<TaskModelResponse> tTaskModelList = [tTaskModelResponse];
    final List<TaskEntity> tTaskEntityList = [tTaskModelResponse.toEntity()];

    test(
        'should return Right<List<TaskEntity>> when the call to remote data source is successful',
        () async {
      // Arrange
      when(mockRemoteDataSource.getTasks('2345233582'))
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
      verify(mockRemoteDataSource.getTasks('2345233582'));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test(
        'should return Left(ServerFailure) when the call to remote data source throws ServerFailure',
        () async {
      // Arrange
      when(mockRemoteDataSource.getTasks('2345233582'))
          .thenThrow(ServerFailure(message: 'Server Error'));

      // Act
      final result = await repository.getTasks('2345233582');

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Server Error');
        },
        (_) => fail('Expected Left but got Right'),
      );
      verify(mockRemoteDataSource.getTasks('2345233582'));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test(
        'should return Left(ServerFailure) when the call to remote data source throws a generic exception',
        () async {
      // Arrange
      when(mockRemoteDataSource.getTasks('2345233582')).thenThrow(Exception());

      // Act
      final result = await repository.getTasks('2345233582');

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Unexpected Error');
        },
        (_) => fail('Expected Left but got Right'),
      );
      verify(mockRemoteDataSource.getTasks('2345233582'));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test(
        'should return Right(empty list) when remote data source returns an empty list',
        () async {
      // Arrange
      when(mockRemoteDataSource.getTasks('2345233582')).thenAnswer((_) async => []);

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
      verify(mockRemoteDataSource.getTasks('2345233582'));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
