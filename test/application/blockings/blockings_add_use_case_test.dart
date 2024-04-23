import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/blockings/application_service/blockings_add_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/infrastructure/in_memory/blockings/in_memory_blockings_repository.dart';
import 'package:studyhub/infrastructure/repositories/in_memory_logger.dart';

void main() {
  final session = MockSession();
  final repository = InMemoryBlockingsRepository();
  final logger = InMemoryLogger();

  group("favorite teachers add use case", () {
    test("should add favorite teachers", () async {
      final teacherId = TeacherId("01234567890123456789");
      final usecase = BlockingsAddUseCase(
        session: session,
        repository: repository,
        logger: logger,
      );
      await usecase.execute(teacherId);
      debugPrint(repository.store.toString());
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
