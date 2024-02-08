import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/favorite_teachers/application_service/favorite_teachers_delete_use_case.dart';
import 'package:studyhub/application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import 'package:studyhub/application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/favorite_teachers/models/favorite_teachers.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart';

void main() {
  final session = MockSession();
  var repository = InMemoryFavoriteTeachersRepository();

  final studentId = session.studentId;
  final teacherId = TeacherId("01234567890123456789");
  final favoriteTeacher =
      FavoriteTeachers(studentId: studentId, teacherIdList: [teacherId]);

  group("favorite teachers delete use case", () {
    test("should delete a favorite teacher", () async {
      repository.store[studentId] = favoriteTeacher;
      final usecase = FavoriteTeachersDeleteUseCase(
          session: session, repository: repository);
      await usecase.execute(teacherId);
      debugPrint(repository.store.toString());
    });

    test("should throw teacher not found error", () {
      repository = InMemoryFavoriteTeachersRepository();
      final usecase = FavoriteTeachersDeleteUseCase(
          session: session, repository: repository);

      expect(() async {
        await usecase.execute(teacherId);
      },
          throwsA(const FavoriteTeachersUseCaseException(
              FavoriteTeachersUseCaseExceptionDetail.favoriteTeacherNotFound)));
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
