// test/domain/usecases/delete_task_usecase_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';
import 'package:todo/domain/usecases/delete_task_usecase.dart';


import 'delete_task_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TasksRepository>()])
void main() {
  late DeleteTaskUseCase useCase;
  late MockTasksRepository mockTasksRepository;

  setUp(() {
    mockTasksRepository = MockTasksRepository();
    useCase = DeleteTaskUseCase(mockTasksRepository);
  });

  final tId = "2995104339";

  test(
      'should call repository.deleteTask with the correct id and return Right(true) when deletion is successful',
          () async {
        // Arrange
        when(mockTasksRepository.deleteTask(tId))
            .thenAnswer((_) async => Right(true));

        // Act
        final result = await useCase(tId);

        // Assert
        verify(mockTasksRepository.deleteTask(tId));
        expect(result, Right(true));
        verifyNoMoreInteractions(mockTasksRepository);
      });

  test(
      'should return ServerFailure when repository.deleteTask fails with a ServerFailure',
          () async {
        // Arrange
        when(mockTasksRepository.deleteTask(tId))
            .thenAnswer((_) async => Left(ServerFailure(message: 'Failed to delete task')));

        // Act
        final result = await useCase(tId);

        // Assert
        verify(mockTasksRepository.deleteTask(tId));
        expect(result, Left(ServerFailure(message: 'Failed to delete task')));
        verifyNoMoreInteractions(mockTasksRepository);
      });

  test(
      'should return ServerFailure when repository.deleteTask throws an exception',
          () async {
        // Arrange
        when(mockTasksRepository.deleteTask(tId))
            .thenThrow(Exception());

        // Act
        final result = await useCase(tId);

        // Assert
        verify(mockTasksRepository.deleteTask(tId));
        // Depending on your implementation, you might need to handle exceptions differently
        // Here, assuming that the use case catches the exception and returns a ServerFailure
        expect(result, Left(ServerFailure(message: 'Failed to delete task')));
        verifyNoMoreInteractions(mockTasksRepository);
      });
}
