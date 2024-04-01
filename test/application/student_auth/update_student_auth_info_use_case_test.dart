import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/student_auth/application_service/student_auth_info_without_password.dart';
import 'package:studyhub/application/student_auth/application_service/update_student_auth_info_command.dart';
import 'package:studyhub/application/student_auth/application_service/update_student_auth_info_use_case.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_get_student_auth_query_service.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';

void main() async {
  final repository = InMemoryStudentAuthRepository();
  final queryService =
      InMemoryGetStudentAuthQueryService(repository: repository);

  final stream = queryService.userChanges();
  stream.listen((data) {
    debugPrint('from stream');
    _printStudentAuthInfoWithoutPassword(data);
  });

  final emailAddress = EmailAddress('test@example.com');
  final password = Password('password');
  // final studentId = StudentId('${'0' * (StudentId.minLength + 9)}1');

  await repository.createWithEmailAndPassword(
      emailAddress: emailAddress, password: password);

  setUp(() async {
    await repository.signIn(emailAddress: emailAddress, password: password);
  });

  group('update use case', () {
    test('should update email address', () async {
      final useCase = UpdateStudentAuthInfoUseCase(repository: repository);
      final command = UpdateStudentAuthInfoCommand(
          emailAddress: 'newtest@example.com',
          emailAddressToResetPassword: null);
      await useCase.execute(command);
    });

    test('should send password update email', () async {
      final useCase = UpdateStudentAuthInfoUseCase(repository: repository);
      final command = UpdateStudentAuthInfoCommand(
          emailAddress: null, emailAddressToResetPassword: 'test@example.com');
      await useCase.execute(command);
    });
  });
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
