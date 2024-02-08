import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/blockings/models/blockings.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';

void main() {
  group("constructor", () {
    test("not_throw_exception", () {
      final blockings = Blockings(
          studentId: StudentId("01234567890123456789"), teacherIdList: []);
      expect(() => blockings, returnsNormally);
    });

    test("duplicated teacher", () {
      expect(
          () => Blockings(
                studentId: StudentId("01234567890123456789"),
                teacherIdList: [
                  for (var i = 0; i < 3; i++) TeacherId("01234567890123456789")
                ],
              ),
          throwsA(isA<DomainException>()));
    });

    test("should throw teacher not found error", () {
      expect(
          () => Blockings(
                studentId: StudentId("01234567890123456789"),
                teacherIdList: [],
              ).delete(TeacherId("00000000000000000000")),
          throwsA(isA<DomainException>()));
    });
  });
}
