import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/application/student/application_service/student_create_use_case.dart';
import 'package:studyhub/application/student/application_service/student_delete_use_case.dart';
import 'package:studyhub/application/student_auth/application_service/student_auth_info_without_password.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_get_student_auth_query_service.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';

void main() async {
  final studentAuthRepository = InMemoryStudentAuthRepository();
  final studentRepository = InMemoryStudentRepository();
  final profilePhotoRepository = InMemoryPhotoRepository();
  final session = MockSession();
  final queryService =
      InMemoryGetStudentAuthQueryService(repository: studentAuthRepository);

  final stream = queryService.userChanges();
  stream.listen((data) {
    debugPrint('from stream');
    _printStudentAuthInfoWithoutPassword(data);
  });

  final createUsecase = StudentCreateUseCase(
    studentAuthRepository: studentAuthRepository,
    studentRepository: studentRepository,
  );
  const emailAddressData = 'test@example.com';
  await createUsecase.execute(
    emailAddressData: emailAddressData,
    passwordData: 'password1',
  );
  final studentId =
      studentAuthRepository.emailToIdMap[EmailAddress(emailAddressData)];

  setUp(() {});

  group('delete use case', () {
    test('should delete student', () {
      final usecase = StudentDeleteUseCase(
        session: session,
        studentAuthRepository: studentAuthRepository,
        studentRepository: studentRepository,
        photoRepository: profilePhotoRepository,
      );

      usecase.execute();

      expect(studentRepository.store[studentId], isNull);
      expect(studentAuthRepository.store[studentId], isNull);
      expect(profilePhotoRepository.store[studentId], isNull);
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('${'0' * (StudentId.minLength + 9)}1');
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
