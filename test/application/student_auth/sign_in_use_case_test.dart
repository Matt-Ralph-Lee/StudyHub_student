import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/student_auth/application_service/sign_in_use_case.dart';
import 'package:studyhub/application/student_auth/application_service/student_auth_info_without_password.dart';
import 'package:studyhub/domain/student/service/student_service.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_get_student_auth_query_service.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';
import 'package:studyhub/infrastructure/repositories/in_memory_logger.dart';

void main() async {
  final repository = InMemoryStudentAuthRepository();
  final studentRepository = InMemoryStudentRepository();
  final queryService =
      InMemoryGetStudentAuthQueryService(repository: repository);
  final logger = InMemoryLogger();
  final service = StudentService(studentRepository);

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
      final useCase = SignInUseCase(
        repository: repository,
        logger: logger,
        service: service,
      );
      await useCase.execute(
          emailAddressData: 'test@example.com', passwordData: 'password');
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
