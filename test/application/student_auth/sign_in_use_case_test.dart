import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/student_auth/application_service/sign_in_use_case.dart';
import 'package:studyhub/application/student_auth/application_service/student_auth_info_without_password.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';
import 'package:studyhub/domain/student_auth/models/student_auth_info.dart';
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
  await repository.signOut();

  setUp(() => null);

  group('sign in use case', () {
    test('should sign in', () async {
      final useCase = SignInUseCase(repository: repository);
      await useCase.execute(
          emailAddressData: 'test@example.com', passwordData: 'password');
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
    debugPrint('${null}\n');
    return;
  }
  final studentId = studentAuthInfoWithoutPassword.studentId;
  final emailAddress = studentAuthInfoWithoutPassword.emailAddress;
  final isVerified = studentAuthInfoWithoutPassword.isVerified;

  debugPrint(
      'studentId: ${studentId.value}\nemailAddress: ${emailAddress.value}\nisVerified: $isVerified\n');
}
