// Mocks generated by Mockito 5.4.4 from annotations
// in todo/test/data/datasource/projects_remote_datasource_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo/data/models/comment_model.dart' as _i7;
import 'package:todo/data/models/project_model_response.dart' as _i2;
import 'package:todo/data/models/task_data_request.dart' as _i6;
import 'package:todo/data/models/task_model_response.dart' as _i3;
import 'package:todo/services/api/project_service.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProjectModelResponse_0 extends _i1.SmartFake
    implements _i2.ProjectModelResponse {
  _FakeProjectModelResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTaskModelResponse_1 extends _i1.SmartFake
    implements _i3.TaskModelResponse {
  _FakeTaskModelResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProjectService].
///
/// See the documentation for Mockito's code generation for more information.
class MockProjectService extends _i1.Mock implements _i4.ProjectService {
  MockProjectService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i2.ProjectModelResponse>> getProjects() =>
      (super.noSuchMethod(
        Invocation.method(
          #getProjects,
          [],
        ),
        returnValue: _i5.Future<List<_i2.ProjectModelResponse>>.value(
            <_i2.ProjectModelResponse>[]),
      ) as _i5.Future<List<_i2.ProjectModelResponse>>);

  @override
  _i5.Future<void> deleteProjects(String? projectId) => (super.noSuchMethod(
        Invocation.method(
          #deleteProjects,
          [projectId],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<_i2.ProjectModelResponse> createProject(
          Map<String, dynamic>? body) =>
      (super.noSuchMethod(
        Invocation.method(
          #createProject,
          [body],
        ),
        returnValue: _i5.Future<_i2.ProjectModelResponse>.value(
            _FakeProjectModelResponse_0(
          this,
          Invocation.method(
            #createProject,
            [body],
          ),
        )),
      ) as _i5.Future<_i2.ProjectModelResponse>);

  @override
  _i5.Future<List<_i3.TaskModelResponse>> getTasks(String? projectId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [projectId],
        ),
        returnValue: _i5.Future<List<_i3.TaskModelResponse>>.value(
            <_i3.TaskModelResponse>[]),
      ) as _i5.Future<List<_i3.TaskModelResponse>>);

  @override
  _i5.Future<_i3.TaskModelResponse> createTask(_i6.TaskDataRequest? taskData) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTask,
          [taskData],
        ),
        returnValue:
            _i5.Future<_i3.TaskModelResponse>.value(_FakeTaskModelResponse_1(
          this,
          Invocation.method(
            #createTask,
            [taskData],
          ),
        )),
      ) as _i5.Future<_i3.TaskModelResponse>);

  @override
  _i5.Future<void> deleteTask(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [id],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> closeTask(String? id) => (super.noSuchMethod(
        Invocation.method(
          #closeTask,
          [id],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<_i3.TaskModelResponse> updateTask(
    _i6.TaskDataRequest? taskData,
    String? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [
            taskData,
            id,
          ],
        ),
        returnValue:
            _i5.Future<_i3.TaskModelResponse>.value(_FakeTaskModelResponse_1(
          this,
          Invocation.method(
            #updateTask,
            [
              taskData,
              id,
            ],
          ),
        )),
      ) as _i5.Future<_i3.TaskModelResponse>);

  @override
  _i5.Future<List<_i7.CommentModel>> getAllComments(String? taskId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getComments,
          [taskId],
        ),
        returnValue:
            _i5.Future<List<_i7.CommentModel>>.value(<_i7.CommentModel>[]),
      ) as _i5.Future<List<_i7.CommentModel>>);
}
