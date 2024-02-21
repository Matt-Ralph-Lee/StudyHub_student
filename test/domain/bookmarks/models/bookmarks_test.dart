import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/bookmarks/models/bookmarks.dart';
import 'package:studyhub/domain/question/models/question_id.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';
import 'package:studyhub/domain/student/models/student_id.dart';

void main() {
  group("constructor", () {
    test("not_throw_exception", () {
      final bookmarks = Bookmarks(
          studentId: StudentId("01234567890123456789"), questionIdSet: {});
      expect(() => bookmarks, returnsNormally);
    });

    test("should throw teacher not found error", () {
      expect(
          () => Bookmarks(
                studentId: StudentId("01234567890123456789"),
                questionIdSet: {},
              ).delete(QuestionId("00000000000000000000")),
          throwsA(isA<DomainException>()));
    });
  });
}
