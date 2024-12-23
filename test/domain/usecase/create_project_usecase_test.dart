import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/repositories/projects_repository.dart';
import 'package:todo/domain/usecases/create_project_usecase.dart';

import 'create_project_usecase_test.mocks.dart';

@GenerateMocks([ProjectsRepository])
void main() {
  late CreateProjectUseCase useCase;
  late MockProjectsRepository mockProjectsRepository;

  setUp(() {
    mockProjectsRepository = MockProjectsRepository();
    useCase = CreateProjectUseCase(mockProjectsRepository);
  });

  group('CreateProjectUseCase', () {
    final tProject = Project(
      id: "1",
      name: "New Project",
      commentCount: 0,
      order: 1,
      color: "#FFFFFF",
      isShared: false,
      isFavorite: false,
      parentId: null,
      isInboxProject: false,
      isTeamInbox: false,
      viewStyle: "list",
      url: "https://todoist.com/showProject?id=1",
    );

    const tParams = ("New Project");

    test(
        'should return Right<Project> when the call to repository is successful',
        () async {
      // Arrange
      when(mockProjectsRepository.createProject(any))
          .thenAnswer((_) async => Right(tProject));

      // Act
      final result = await useCase.call(tParams);

      // Assert
      expect(result, Right(tProject));
      verify(mockProjectsRepository.createProject(tParams));
      verifyNoMoreInteractions(mockProjectsRepository);
    });

    test(
        'should return Left(ServerFailure) when the call to repository fails with ServerFailure',
        () async {
      // Arrange
      when(mockProjectsRepository.createProject(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server Error')));

      // Act
      final result = await useCase.call(tParams);

      // Assert
      expect(result, const Left(ServerFailure(message: 'Server Error')));
      verify(mockProjectsRepository.createProject(tParams));
      verifyNoMoreInteractions(mockProjectsRepository);
    });

    test(
        'should return Left(ServerFailure) when the repository returns a ServerFailure',
        () async {
      // Arrange
      when(mockProjectsRepository.createProject(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Unexpected Error')));

      // Act
      final result = await useCase.call(tParams);

      // Assert
      expect(result, const Left(ServerFailure(message: 'Unexpected Error')));
      verify(mockProjectsRepository.createProject(tParams));
      verifyNoMoreInteractions(mockProjectsRepository);
    });
  });
}
