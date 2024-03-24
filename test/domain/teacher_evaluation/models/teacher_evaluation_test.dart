import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';
import 'package:studyhub/domain/teacher_evaluation/models/teacher_evaluation.dart';
import 'package:studyhub/domain/teacher_evaluation/models/teacher_evaluation_comment.dart';
import 'package:studyhub/domain/teacher_evaluation/models/teacher_evaluation_rating.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';

void main() {
  group("constructor", () {
    test("not_throw_exception", () {
      final teacherEvaluation = TeacherEvaluation(
        from: StudentId("01234567890123456789"),
        to: TeacherId("01234567890123456789"),
        rating: TeacherEvaluationRating(5),
        comment: TeacherEvaluationComment("hello, that was great"),
        createdAt: DateTime.now(),
      );
      expect(() => teacherEvaluation, returnsNormally);
    });

    test("invalid rating value", () {
      expect(
          () => TeacherEvaluation(
                from: StudentId("01234567890123456789"),
                to: TeacherId("01234567890123456789"),
                rating: TeacherEvaluationRating(0),
                comment: TeacherEvaluationComment("hello, that was great"),
                createdAt: DateTime.now(),
              ),
          throwsA(isA<DomainException>()));
    });

    test("invalid comment value", () {
      expect(
          () => TeacherEvaluation(
                from: StudentId("01234567890123456789"),
                to: TeacherId("01234567890123456789"),
                rating: TeacherEvaluationRating(4),
                comment: TeacherEvaluationComment("a"),
                createdAt: DateTime.now(),
              ),
          throwsA(isA<DomainException>()));
    });
  });
}
