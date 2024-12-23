
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/repositories/tasks_repository.dart';
import 'package:todo/domain/usecases/CloseTaskUseCase.dart';


import 'close_task_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TasksRepository>()])
void main() {
  late CloseTaskUseCase useCase;
  late MockTasksRepository mockTasksRepository;

  setUp(() {
    mockTasksRepository = MockTasksRepository();
    useCase = CloseTaskUseCase(mockTasksRepository);
  });

  final tId = "2995104339";

  test(
    'Should call repository.closeTask with the correct id and return Right(true) when closing is successful',
        () async {
      // Arrange
      when(mockTasksRepository.closeTask(tId))
          .thenAnswer((_) async => Right(true));

      // Act
      final result = await useCase(tId);

      // Assert
      verify(mockTasksRepository.closeTask(tId));
      expect(result, Right(true));
      verifyNoMoreInteractions(mockTasksRepository);
    },
  );

  test(
    'Should return ServerFailure when repository.closeTask fails with a ServerFailure',
        () async {
      // Arrange
      when(mockTasksRepository.closeTask(tId))
          .thenAnswer((_) async => Left(ServerFailure(message: 'Failed to close task')));

      // Act
      final result = await useCase(tId);

      // Assert
      verify(mockTasksRepository.closeTask(tId));
      expect(result, Left(ServerFailure(message: 'Failed to close task')));
      verifyNoMoreInteractions(mockTasksRepository);
    },
  );

  test(
    'Should return ServerFailure when repository.closeTask throws an exception',
        () async {
      // Arrange
      when(mockTasksRepository.closeTask(tId))
          .thenAnswer((_) async => throw Exception());

      // Act
      final result = await useCase(tId);

      // Assert
      verify(mockTasksRepository.closeTask(tId));
      // Assuming that the UseCase handles exceptions and returns ServerFailure
      expect(result, Left(ServerFailure(message: 'Failed to close task')));
      verifyNoMoreInteractions(mockTasksRepository);
    },
  );
}
