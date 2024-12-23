// Mocks generated by Mockito 5.4.4 from annotations
// in todo/test/data/repository/tasks_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:hive/hive.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo/data/datasources/local/sync_local_datasource.dart' as _i8;
import 'package:todo/data/datasources/local/tasks_local_datasource.dart' as _i7;
import 'package:todo/data/datasources/remote/tasks_remote_datasource.dart'
    as _i4;
import 'package:todo/data/models/sync_model.dart' as _i9;
import 'package:todo/data/models/task_data_request.dart' as _i6;
import 'package:todo/data/models/task_model_response.dart' as _i2;

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

class _FakeTaskModelResponse_0 extends _i1.SmartFake
    implements _i2.TaskModelResponse {
  _FakeTaskModelResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBox_1<E> extends _i1.SmartFake implements _i3.Box<E> {
  _FakeBox_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TasksRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTasksRemoteDataSource extends _i1.Mock
    implements _i4.TasksRemoteDataSource {
  MockTasksRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i2.TaskModelResponse>> getTasks(
          {required String? projectId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [],
          {#projectId: projectId},
        ),
        returnValue: _i5.Future<List<_i2.TaskModelResponse>>.value(
            <_i2.TaskModelResponse>[]),
      ) as _i5.Future<List<_i2.TaskModelResponse>>);

  @override
  _i5.Future<_i2.TaskModelResponse> getTask(String? taskId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTask,
          [taskId],
        ),
        returnValue:
            _i5.Future<_i2.TaskModelResponse>.value(_FakeTaskModelResponse_0(
          this,
          Invocation.method(
            #getTask,
            [taskId],
          ),
        )),
      ) as _i5.Future<_i2.TaskModelResponse>);

  @override
  _i5.Future<_i2.TaskModelResponse> createTask(_i6.TaskDataRequest? taskData) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTask,
          [taskData],
        ),
        returnValue:
            _i5.Future<_i2.TaskModelResponse>.value(_FakeTaskModelResponse_0(
          this,
          Invocation.method(
            #createTask,
            [taskData],
          ),
        )),
      ) as _i5.Future<_i2.TaskModelResponse>);

  @override
  _i5.Future<bool> deleteTask(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);

  @override
  _i5.Future<bool> closeTask(String? id) => (super.noSuchMethod(
        Invocation.method(
          #closeTask,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);

  @override
  _i5.Future<_i2.TaskModelResponse> updateTask(
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
            _i5.Future<_i2.TaskModelResponse>.value(_FakeTaskModelResponse_0(
          this,
          Invocation.method(
            #updateTask,
            [
              taskData,
              id,
            ],
          ),
        )),
      ) as _i5.Future<_i2.TaskModelResponse>);
}

/// A class which mocks [TasksLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTasksLocalDataSource extends _i1.Mock
    implements _i7.TasksLocalDataSource {
  MockTasksLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> saveTasks(List<_i2.TaskModelResponse>? tasks) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveTasks,
          [tasks],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> saveTask(_i2.TaskModelResponse? task) => (super.noSuchMethod(
        Invocation.method(
          #saveTask,
          [task],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<List<_i2.TaskModelResponse>> getTasks({String? projectId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [],
          {#projectId: projectId},
        ),
        returnValue: _i5.Future<List<_i2.TaskModelResponse>>.value(
            <_i2.TaskModelResponse>[]),
      ) as _i5.Future<List<_i2.TaskModelResponse>>);

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
  _i5.Future<void> deleteTasksByProject(String? projectId) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteTasksByProject,
          [projectId],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [SyncLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSyncLocalDataSource extends _i1.Mock
    implements _i8.SyncLocalDataSource {
  MockSyncLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Box<_i9.SyncOperation> get syncBox => (super.noSuchMethod(
        Invocation.getter(#syncBox),
        returnValue: _FakeBox_1<_i9.SyncOperation>(
          this,
          Invocation.getter(#syncBox),
        ),
      ) as _i3.Box<_i9.SyncOperation>);

  @override
  _i5.Future<void> addOperation(_i9.SyncOperation? operation) =>
      (super.noSuchMethod(
        Invocation.method(
          #addOperation,
          [operation],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<List<_i9.SyncOperation>> getOperations() => (super.noSuchMethod(
        Invocation.method(
          #getOperations,
          [],
        ),
        returnValue:
            _i5.Future<List<_i9.SyncOperation>>.value(<_i9.SyncOperation>[]),
      ) as _i5.Future<List<_i9.SyncOperation>>);

  @override
  _i5.Future<void> removeOperation(int? index) => (super.noSuchMethod(
        Invocation.method(
          #removeOperation,
          [index],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> clearQueue() => (super.noSuchMethod(
        Invocation.method(
          #clearQueue,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
