import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/projects_remote_datasource.dart';
import 'package:todo/data/models/project_model_response.dart';
import 'package:todo/services/api/project_service.dart';

import 'projects_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ProjectService])
void main() {
  late ProjectsRemoteDataSourceImpl dataSource;
  late MockProjectService mockProjectService;

  setUp(() {
    mockProjectService = MockProjectService();
    dataSource = ProjectsRemoteDataSourceImpl(mockProjectService);
  });

  group('getProjects', () {
    final tProjectModelResponse = ProjectModelResponse(
      id: "1",
      name: "Project 1",
      commentCount: 0,
      order: 1,
      color: "#FFFFFF",
      isShared: false,
      isFavorite: false,
      parentId: null,
      isInboxProject: false,
      isTeamInbox: false,
      viewStyle: "list",
      url: "https://example.com/projects/1",
    );

    final List<ProjectModelResponse> tProjectList = [tProjectModelResponse];

    test(
        'should return a list of ProjectModelResponse when the call to service is successful',
        () async {
      // Arrange
      when(mockProjectService.getProjects())
          .thenAnswer((_) async => tProjectList);

      // Act
      final result = await dataSource.getProjects();

      // Assert
      expect(result, tProjectList);
      verify(mockProjectService.getProjects());
      verifyNoMoreInteractions(mockProjectService);
    });

    test(
        'should throw ServerFailure when the call to service throws an exception',
        () async {
      // Arrange
      when(mockProjectService.getProjects()).thenThrow(Exception());

      // Act
      final call = dataSource.getProjects();

      // Assert
      expect(() => call, throwsA(isA<ServerFailure>()));
      verify(mockProjectService.getProjects());
      verifyNoMoreInteractions(mockProjectService);
    });
  });

  group('deleteProjects', () {
    const String tId = "1";

    test('should return true when the call to service is successful', () async {
      // Arrange
      when(mockProjectService.deleteProjects(tId))
          .thenAnswer((_) async => true);

      // Act
      final result = await dataSource.deleteProjects(tId);

      // Assert
      expect(result, true);
      verify(mockProjectService.deleteProjects(tId));
      verifyNoMoreInteractions(mockProjectService);
    });

    test(
        'should throw ServerFailure when the call to service throws an exception',
        () async {
      // Arrange
      when(mockProjectService.deleteProjects(tId)).thenThrow(Exception());

      // Act
      final call = dataSource.deleteProjects(tId);

      // Assert
      expect(() => call, throwsA(isA<ServerFailure>()));
      verify(mockProjectService.deleteProjects(tId));
      verifyNoMoreInteractions(mockProjectService);
    });
  });

  group('createProjects', () {
    const String tName = "New Project";
    const String tUuid = "uuid-12345";
    final tProjectModelResponse = ProjectModelResponse(
      id: "2",
      name: tName,
      commentCount: 0,
      order: 2,
      color: "#000000",
      isShared: false,
      isFavorite: false,
      parentId: null,
      isInboxProject: false,
      isTeamInbox: false,
      viewStyle: "list",
      url: "https://example.com/projects/2",
    );

    test(
        'should return ProjectModelResponse when the call to service is successful',
        () async {
      // Arrange
      when(mockProjectService.createProject({"name": tName}))
          .thenAnswer((_) async => tProjectModelResponse);

      // Act
      final result = await dataSource.createProjects(tName);

      // Assert
      expect(result, tProjectModelResponse);
      verify(mockProjectService.createProject({"name": tName}));
      verifyNoMoreInteractions(mockProjectService);
    });

    test(
        'should throw ServerFailure when the call to service throws an exception',
        () async {
      // Arrange
      when(mockProjectService.createProject({"name": tName}))
          .thenThrow(Exception());

      // Act
      final call = dataSource.createProjects(tName);

      // Assert
      expect(() => call, throwsA(isA<ServerFailure>()));
      verify(mockProjectService.createProject({"name": tName}));
      verifyNoMoreInteractions(mockProjectService);
    });
  });
}
