import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/bookmarks/models/bookmarks.dart';
import 'package:studyhub/domain/question/models/question_id.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';
import 'package:studyhub/domain/student/models/student_id.dart';

void main() {
  group("constructor", () {
    test("not_throw_exception", () {
      final bookmarks = Bookmarks(
          studentId: StudentId("01234567890123456789"), questionIdList: []);
      expect(() => bookmarks, returnsNormally);
    });

    test("invalid number of teacher", () {
      expect(
          () => Bookmarks(
                studentId: StudentId("01234567890123456789"),
                questionIdList: [
                  for (var i = 0; i < Bookmarks.maxLength + 1; i++)
                    QuestionId("0123456789012345678$i")
                ],
              ),
          throwsA(isA<DomainException>()));
    });

    test("duplicated teacher", () {
      expect(
          () => Bookmarks(
                studentId: StudentId("01234567890123456789"),
                questionIdList: [
                  for (var i = 0; i < 3; i++) QuestionId("01234567890123456789")
                ],
              ),
          throwsA(isA<DomainException>()));
    });

    test("should throw teacher not found error", () {
      expect(
          () => Bookmarks(
                studentId: StudentId("01234567890123456789"),
                questionIdList: [],
              ).delete(QuestionId("00000000000000000000")),
          throwsA(isA<DomainException>()));
    });
  });
}
