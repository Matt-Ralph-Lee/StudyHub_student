import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/application/student/application_service/student_create_use_case.dart';
import 'package:studyhub/application/student_auth/application_service/student_auth_info_without_password.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_get_student_auth_query_service.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';

void main() {
  final repository = InMemoryStudentAuthRepository();
  final studentRepository = InMemoryStudentRepository();
  final queryService =
      InMemoryGetStudentAuthQueryService(repository: repository);

  final stream = queryService.userChanges();
  stream.listen((data) {
    debugPrint('from stream');
    _printStudentAuthInfoWithoutPassword(data);
  });

  setUp(() {});

  group('create use case', () {
    test('should create a new student with valid email and password', () async {
      const emailAddressData = 'test@example.com';
      const passwordData = 'password1';

      final usecase = StudentCreateUseCase(
        studentAuthRepository: repository,
        studentRepository: studentRepository,
      );

      await usecase.execute(
        emailAddressData: emailAddressData,
        passwordData: passwordData,
      );

      final studentId = repository.emailToIdMap[EmailAddress(emailAddressData)];
      expect(studentId, isNotNull);
      expect(repository.store[studentId], isNotNull);
      expect(repository.currentStudentId, studentId);
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('${'0' * (StudentId.minLength + 9)}1');

  @override
  EmailAddress get emailAddress => EmailAddress("test@email.com");
}

void _printStudentAuthInfoWithoutPassword(
    final StudentAuthInfoWithoutPassword? studentAuthInfoWithoutPassword) {
  if (studentAuthInfoWithoutPassword == null) {
    debugPrint('${null}\n');
    return;
  }
  final studentId = studentAuthInfoWithoutPassword.studentId;
  final emailAddress = studentAuthInfoWithoutPassword.emailAddress;
  final isVerified = studentAuthInfoWithoutPassword.isVerified;

  debugPrint(
      'studentId: ${studentId.value}\nemailAddress: ${emailAddress.value}\nisVerified: $isVerified\n');
}
