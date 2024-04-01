import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/application/teacher_evaluation/application_service/teacher_evaluation_add_use_case.dart';
import 'package:studyhub/domain/answer_list/models/answer_id.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/infrastructure/in_memory/answer/in_memory_answer_repository.dart';
import 'package:studyhub/infrastructure/in_memory/teacher_evaluation/in_memory_teacher_evaluation_repository.dart';

void main() {
  final session = MockSession();
  final repository = InMemoryTeacherEvaluationRepository();
  final answerRepository = InMemoryAnswerRepository();

  group("evaluation add use case", () {
    test("should add favorite teachers", () async {
      final to = TeacherId("01234567890123456789");
      const ratingData = 4;
      const commentData = "すごくわかりやすかったです。また今度教えてください。";
      final answerId = AnswerId("00000000000000000000");
      final usecase = TeacherEvaluationAddUseCase(
        session: session,
        repository: repository,
        answerRepository: answerRepository,
      );
      await usecase.execute(
        answerId: answerId,
        to: to,
        ratingData: ratingData,
        commentData: commentData,
      );
      debugPrint(repository.store.toString());
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
