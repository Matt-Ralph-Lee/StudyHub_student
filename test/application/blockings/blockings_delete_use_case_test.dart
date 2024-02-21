import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/blockings/application_service/blockings_delete_use_case.dart';
import 'package:studyhub/application/blockings/exception/blockings_use_case_exception.dart';
import 'package:studyhub/application/blockings/exception/blockings_use_case_exception_detail.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/blockings/models/blockings.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/infrastructure/in_memory/blockings/in_memory_blockings_repository.dart';

void main() {
  final session = MockSession();
  var repository = InMemoryBlockingsRepository();

  final studentId = session.studentId;
  final teacherId = TeacherId("01234567890123456789");
  final favoriteTeacher =
      Blockings(studentId: studentId, teacherIdList: {teacherId});

  group("favorite teachers delete use case", () {
    test("should delete a favorite teacher", () async {
      repository.store[studentId] = favoriteTeacher;
      final usecase =
          BlockingsDeleteUseCase(session: session, repository: repository);
      await usecase.execute(teacherId);
      debugPrint(repository.store.toString());
    });

    test(
        "should throw teacher not found error, cause it hasn't been created yet",
        () {
      repository = InMemoryBlockingsRepository();
      final usecase =
          BlockingsDeleteUseCase(session: session, repository: repository);

      expect(() async {
        await usecase.execute(teacherId);
      },
          throwsA(const BlockingsUseCaseException(
              BlockingsUseCaseExceptionDetail.blockingsNotFound)));
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
