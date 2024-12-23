
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/datasources/local/projects_local_datasource.dart';
import 'package:todo/data/models/project_model_response.dart';

@GenerateMocks([Box])
import 'projects_local_data_source_test.mocks.dart';

void main() {
  late MockBox<ProjectModelResponse> mockProjectBox;
  late ProjectsLocalDataSourceImpl dataSource;

  setUp(() {
    mockProjectBox = MockBox<ProjectModelResponse>();
    dataSource = ProjectsLocalDataSourceImpl(mockProjectBox);
  });

  group('ProjectsLocalDataSourceImpl', () {
    final tProject1 = ProjectModelResponse(
      id: '1',
      name: 'Project One',
      commentCount: 5,
      order: 1,
      color: '#FFFFFF',
      isShared: false,
      isFavorite: true,
      parentId: null,
      isInboxProject: false,
      isTeamInbox: false,
      viewStyle: 'default',
      url: 'http://example.com/project1',
    );

    final tProject2 = ProjectModelResponse(
      id: '2',
      name: 'Project Two',
      commentCount: 3,
      order: 2,
      color: '#000000',
      isShared: true,
      isFavorite: false,
      parentId: '1',
      isInboxProject: false,
      isTeamInbox: true,
      viewStyle: 'kanban',
      url: 'http://example.com/project2',
    );

    final tProjects = [tProject1, tProject2];

    group('saveProjects', () {
      test('should clear the box and save each project', () async {
        // Arrange
        when(mockProjectBox.clear()).thenAnswer((_) async => 0);
        when(mockProjectBox.put(any, any)).thenAnswer((_) async => Future.value());

        // Act
        await dataSource.saveProjects(tProjects);

        // Assert
        verify(mockProjectBox.clear());
        for (var project in tProjects) {
          verify(mockProjectBox.put(project.id, project));
        }
        verifyNoMoreInteractions(mockProjectBox);
      });
    });

    group('saveProject', () {
      test('should save the project to the box', () async {
        // Arrange
        when(mockProjectBox.put(any, any)).thenAnswer((_) async => Future.value());

        // Act
        await dataSource.saveProject(tProject1);

        // Assert
        verify(mockProjectBox.put(tProject1.id, tProject1));
        verifyNoMoreInteractions(mockProjectBox);
      });
    });

    group('getProjects', () {
      test('should return a list of projects from the box', () async {
        // Arrange
        when(mockProjectBox.values).thenReturn(tProjects);

        // Act
        final result = await dataSource.getProjects();

        // Assert
        expect(result, equals(tProjects));
        verify(mockProjectBox.values);
        verifyNoMoreInteractions(mockProjectBox);
      });
    });

    group('deleteProject', () {
      test('should delete the project from the box', () async {
        // Arrange
        when(mockProjectBox.delete(any)).thenAnswer((_) async => Future.value());

        // Act
        await dataSource.deleteProject(tProject1.id);

        // Assert
        verify(mockProjectBox.delete(tProject1.id));
        verifyNoMoreInteractions(mockProjectBox);
      });
    });
  });
}
