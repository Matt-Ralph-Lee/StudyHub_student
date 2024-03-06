import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/student_auth/application_service/student_auth_info_without_password.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';
import 'package:studyhub/domain/student_auth/models/student_auth_info.dart';
import 'package:studyhub/infrastructure/exceptions/student_auth/student_auth_infrastructure_exception.dart';
import 'package:studyhub/infrastructure/exceptions/student_auth/student_auth_infrastructure_exception_detail.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_get_student_auth_query_service.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';

void main() async {
  final repository = InMemoryStudentAuthRepository();
  final queryService =
      InMemoryGetStudentAuthQueryService(repository: repository);

  final emailAddress1 = EmailAddress('test1@example.com');
  final password1 = Password('password1');
  final studentId1 = StudentId('${'0' * (StudentId.minLength + 9)}1');

  final stream = queryService.userChanges();
  stream.listen((data) {
    debugPrint('from stream');
    _printStudentAuthInfoWithoutPassword(data);
  });

  await repository.createWithEmailAndPassword(
      emailAddress: emailAddress1, password: password1);

  setUp(() {});

  group('createWithEmailAndPassword function', () {
    final emailAddress2 = EmailAddress('test2@example.com');
    final password2 = Password('password2');
    test('should create studentAuthInfo', () async {
      await repository.createWithEmailAndPassword(
        emailAddress: emailAddress2,
        password: password2,
      );

      final studentId = repository.emailToIdMap[emailAddress2];
      expect(studentId, isNotNull);

      final storedStudentAuthInfo = repository.store[studentId];
      expect(storedStudentAuthInfo, isNotNull);

      expect(repository.currentStudentId, studentId);

      final mappedId = repository.emailToIdMap[emailAddress2];
      expect(mappedId, studentId);
      _printStudentAuthInfo(storedStudentAuthInfo);
    });
  });

  group('signIn function', () {
    test('should sign in', () async {
      await repository.signIn(emailAddress: emailAddress1, password: password1);
      expect(repository.currentStudentId, studentId1);
    });

    test('should throw error on wrong Password', () async {
      expect(() async {
        await repository.signIn(
            emailAddress: emailAddress1, password: Password('wrong-password'));
      },
          throwsA(isA<StudentAuthInfrastructureException>().having(
            (p0) => p0.detail,
            'detail',
            StudentAuthInfrastructureExceptionDetail.wrongPassword,
          )));
    });
  });

  group('signOut function', () {
    test('should sign out', () async {
      await repository.signIn(emailAddress: emailAddress1, password: password1);
      await repository.signOut();
      expect(repository.currentStudentId, isNull);
    });
  });

  group('sendEmailVerification function', () {
    test('should change isVerified', () async {
      await repository.signIn(emailAddress: emailAddress1, password: password1);
      await repository.sendEmailVerification();
      expect(repository.store[studentId1]!.isVerified, isTrue);
    });
  });

  group('delete function', () {
    final emailAddress3 = EmailAddress('test3@example.com');
    final password3 = Password('password3');
    test('should delete', () async {
      await repository.createWithEmailAndPassword(
          emailAddress: emailAddress3, password: password3);
      final studentId = repository.emailToIdMap[emailAddress3];
      expect(repository.store[studentId], isNotNull);

      await repository.delete();

      expect(repository.store[studentId], isNull);
      expect(repository.currentStudentId, isNull);
      expect(repository.emailToIdMap[emailAddress3], isNull);
      expect(repository.currentStudentId, isNull);
    });
  });

  group('updateEmailAddress function', () {
    test('should update email address', () async {
      await repository.signIn(emailAddress: emailAddress1, password: password1);

      final newEmailAddress = EmailAddress('newaddress@example.com');
      await repository.updateEmailAddress(newEmailAddress);
      expect(repository.store[studentId1]?.emailAddress, newEmailAddress);
      expect(repository.emailToIdMap[newEmailAddress], studentId1);
      expect(repository.emailToIdMap[emailAddress1], isNull);

      await repository.updateEmailAddress(emailAddress1);
    });
  });
}

void _printStudentAuthInfo(final StudentAuthInfo? studentAuthInfo) {
  if (studentAuthInfo == null) {
    debugPrint(null);
    return;
  }
  final studentId = studentAuthInfo.studentId;
  final emailAddress = studentAuthInfo.emailAddress;
  final password = studentAuthInfo.password;
  final isVerified = studentAuthInfo.isVerified;

  debugPrint(
      'studentId: ${studentId.value}\nemailAddress: ${emailAddress.value}\npassword: ${password.value}\nisVerified: $isVerified\n');
}

void _printStudentAuthInfoWithoutPassword(
    final StudentAuthInfoWithoutPassword? studentAuthInfoWithoutPassword) {
  if (studentAuthInfoWithoutPassword == null) {
    debugPrint(null);
    return;
  }
  final studentId = studentAuthInfoWithoutPassword.studentId;
  final emailAddress = studentAuthInfoWithoutPassword.emailAddress;
  final isVerified = studentAuthInfoWithoutPassword.isVerified;

  debugPrint(
      'studentId: ${studentId.value}\nemailAddress: ${emailAddress.value}\nisVerified: $isVerified\n');
}
