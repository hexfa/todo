// test/features/projects/domain/usecases/get_projects_usecase_test.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/domain/entities/project.dart';
import 'package:todo/domain/repositories/projects_repository.dart';
import 'package:todo/domain/usecases/get_projects_usecase.dart';

import 'get_projects_usecase_test.mocks.dart';

@GenerateMocks([ProjectsRepository])
void main() {
  late GetProjectsUseCase usecase;
  late MockProjectsRepository mockRepository;

  setUp(() {
    mockRepository = MockProjectsRepository();
    usecase = GetProjectsUseCase(mockRepository);
  });

  final tProjects = [
    Project(
      id: '2203306141',
      name: 'Shopping List',
      commentCount: 10,
      order: 1,
      color: 'charcoal',
      isShared: false,
      isFavorite: false,
      parentId: '220325187',
      isInboxProject: false,
      isTeamInbox: false,
      viewStyle: 'list',
      url: 'https://todoist.com/showProject?id=2203306141',
    )
  ];

  test('should get projects from the repository', () async {
    // arrange
    when(mockRepository.getProjects()).thenAnswer((_) async => Right(tProjects));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right<Failure, List<Project>>(tProjects));
    verify(mockRepository.getProjects());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ServerFailure when something goes wrong', () async {
    // arrange
    when(mockRepository.getProjects())
        .thenAnswer((_) async => const Left<Failure, List<Project>>(ServerFailure(message: 'Server Error')));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, const Left<Failure, List<Project>>(ServerFailure(message: 'Server Error')));
    verify(mockRepository.getProjects());
    verifyNoMoreInteractions(mockRepository);
  });
}
