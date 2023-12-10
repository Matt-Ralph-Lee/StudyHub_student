import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/student_auth/student_auth_creation_exception.dart';
import 'package:studyhub/common/exception/student_auth/student_auth_creation_exception_detail.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';

void main() {
  setUp(() => null);
  group('contructor validation', () {
    test('valid_email_address', () {
      const String email = 'test@example.com';
      final emailAddress = EmailAddress(email);
      expect(emailAddress.value, equals(email));
    });

    test('empty_string', () {
      const String email = '';
      expect(
          () => EmailAddress(email),
          throwsA(isA<StudentAuthCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(StudentAuthCreationExceptionDetail.empty))));
    });

    test('without_at_character', () {
      const String email = 'testexample.com';
      expect(
          () => EmailAddress(email),
          throwsA(isA<StudentAuthCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(StudentAuthCreationExceptionDetail.invalidEmailFormat))));
    });

    test('multiple_at_characters', () {
      const String email = 'test@@example.com';
      expect(
          () => EmailAddress(email),
          throwsA(isA<StudentAuthCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(StudentAuthCreationExceptionDetail.invalidEmailFormat))));
    });

    test('no_at_sign', () {
      const String email = 'testexample.com';
      expect(
          () => EmailAddress(email),
          throwsA(isA<StudentAuthCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(StudentAuthCreationExceptionDetail.invalidEmailFormat))));
    });

    test('no_period_after_at_sign', () {
      const String email = 'test@examplecom';
      expect(
          () => EmailAddress(email),
          throwsA(isA<StudentAuthCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(StudentAuthCreationExceptionDetail.invalidEmailFormat))));
    });
  });
}
