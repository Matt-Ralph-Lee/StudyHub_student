import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/bookmarks/application_service/bookmarks_delete_use_case.dart';
import 'package:studyhub/application/bookmarks/exception/bookmarks_use_case_exception.dart';
import 'package:studyhub/application/bookmarks/exception/bookmarks_use_case_exception_detail.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/bookmarks/models/bookmarks.dart';
import 'package:studyhub/domain/question/models/question_id.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/infrastructure/in_memory/bookmarks/in_memory_bookmarks_repository.dart';
import 'package:studyhub/infrastructure/repositories/in_memory_logger.dart';

void main() {
  final session = MockSession();
  var repository = InMemoryBookmarksRepository();
  final logger = InMemoryLogger();

  final studentId = session.studentId;
  final questionId = QuestionId("01234567890123456789");
  final favoriteTeacher =
      Bookmarks(studentId: studentId, questionIdSet: {questionId});

  group("favorite teachers delete use case", () {
    test("should delete a favorite teacher", () async {
      repository.store[studentId] = favoriteTeacher;
      final usecase = BookmarksDeleteUseCase(
        session: session,
        repository: repository,
        logger: logger,
      );
      await usecase.execute(questionId);
      debugPrint(repository.store.toString());
    });

    test(
        "should throw teacher not found error, cause it hasn't been created yet",
        () {
      repository = InMemoryBookmarksRepository();
      final usecase = BookmarksDeleteUseCase(
        session: session,
        repository: repository,
        logger: logger,
      );

      expect(() async {
        await usecase.execute(questionId);
      },
          throwsA(const BookmarksUseCaseException(
              BookmarksUseCaseExceptionDetail.bookmarksNotFound)));
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');

  @override
  EmailAddress get emailAddress => EmailAddress("test@email.com");
}
