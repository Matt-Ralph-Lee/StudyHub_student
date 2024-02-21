import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/bookmarks/application_service/bookmarks_add_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/question/models/question_id.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/infrastructure/in_memory/bookmarks/in_memory_bookmarks_repository.dart';

void main() {
  final session = MockSession();
  final repository = InMemoryBookmarksRepository();

  group("bookmarks add use case", () {
    test("should add favorite teachers", () async {
      final questionId = QuestionId("01234567890123456789");
      final usecase =
          BookmarksAddUseCase(session: session, repository: repository);
      await usecase.execute(questionId);
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
