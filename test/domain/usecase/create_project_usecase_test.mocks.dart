// Mocks generated by Mockito 5.4.4 from annotations
// in todo/test/domain/usecase/create_project_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo/core/error/failure.dart' as _i5;
import 'package:todo/domain/entities/project.dart' as _i6;
import 'package:todo/domain/repositories/projects_repository.dart' as _i3;

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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProjectsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockProjectsRepository extends _i1.Mock
    implements _i3.ProjectsRepository {
  MockProjectsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Project>>> getProjects() =>
      (super.noSuchMethod(
        Invocation.method(
          #getProjects,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.Project>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.Project>>(
          this,
          Invocation.method(
            #getProjects,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Project>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Project>> createProject(
          String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #createProject,
          [name],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Project>>.value(
            _FakeEither_0<_i5.Failure, _i6.Project>(
          this,
          Invocation.method(
            #createProject,
            [name],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Project>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> deleteProject(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteProject,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteProject,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
}