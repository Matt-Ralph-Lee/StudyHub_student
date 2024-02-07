import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/favorite_teachers/application_service/favorite_teachers_update_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/favorite_teachers/models/favorite_teachers.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart';

void main() {
  final session = MockSession();
  final repository = InMemoryFavoriteTeachersRepository();

  final studentId = session.studentId;
  final favoriteTeachersListData = [
    for (var i = 0; i < 3; i++) "01234567890123456789"
  ];
  final teacherIdList = [
    for (final favoriteTeacherData in favoriteTeachersListData)
      TeacherId(favoriteTeacherData)
  ];

  final favoriteTeachers =
      FavoriteTeachers(studentId: studentId, teacherIdList: teacherIdList);

  tearDown(() {
    repository.store[studentId] = favoriteTeachers;
  });

  group("favorite teachers update use case", () {
    test("should create teacher", () {
      final useCase = FavoriteTeachersUpdateUseCase(
          session: session, repository: repository);
      useCase.execute(favoriteTeachersListData);
    });

    test("should update teacher", () {
      final useCase = FavoriteTeachersUpdateUseCase(
          session: session, repository: repository);
      useCase.execute(favoriteTeachersListData);
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
