import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/student/application_service/student_create_use_case.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/service/student_auth_domain_service.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_factory.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';

void main() {
  final repository = InMemoryStudentAuthRepository();
  final service = StudentAuthDomainService(repository);
  final factory = InMemoryStudentAuthFactory();
  final studentRepository = InMemoryStudentRepository();

  setUp(() {});

  group('create use case', () {
    test('should create a new student with valid email and password', () async {
      const emailAddressData = 'test@example.com';
      const passwordData = 'password123';

      final usecase = StudentCreateUseCase(
        service: service,
        repository: repository,
        factory: factory,
        studentRepository: studentRepository,
      );

      await usecase.execute(
        emailAddressData: emailAddressData,
        passwordData: passwordData,
      );

      final studentId = repository.emailToIdMap[EmailAddress(emailAddressData)];

      debugPrint(repository.store[studentId]!.emailAddress.value);
      debugPrint(repository.store[studentId]!.studentId.value);
      debugPrint(repository.store[studentId]!.isVerified.toString());

      debugPrint(studentRepository.store[studentId]!.name.value);
    });
  });
}
