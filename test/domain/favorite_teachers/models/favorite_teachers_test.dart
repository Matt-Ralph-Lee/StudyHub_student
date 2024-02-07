import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/favorite_teachers/models/favorite_teachers.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';

void main() {
  group("constructor", () {
    test("not_throw_exception", () {
      final favoriteTeachers = FavoriteTeachers(
          studentId: StudentId("01234567890123456789"), teacherIdList: []);
      expect(() => favoriteTeachers, returnsNormally);
    });

    test("invalid number of teacher", () {
      expect(
          () => FavoriteTeachers(
                studentId: StudentId("01234567890123456789"),
                teacherIdList: [
                  for (var i = 0; i < 10; i++)
                    TeacherId("0123456789012345678$i")
                ],
              ),
          throwsA(isA<DomainException>()));
    });

    test("duplicated teacher", () {
      expect(
          () => FavoriteTeachers(
                studentId: StudentId("01234567890123456789"),
                teacherIdList: [
                  for (var i = 0; i < 3; i++) TeacherId("01234567890123456789")
                ],
              ),
          throwsA(isA<DomainException>()));
    });
  });
}
