import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/student_auth/student_auth_creation_exception.dart';
import 'package:studyhub/common/exception/student_auth/student_auth_creation_exception_detail.dart';
import 'package:studyhub/domain/student_auth/models/student_auth_info.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('with_valid_inputs', () {
      final StudentId accountId = StudentId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = false;

      final StudentAuthInfo account = StudentAuthInfo(
        accountId: accountId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      expect(() => account, returnsNormally);
    });

    test('with_invalid_email', () {
      expect(() {
        final StudentId accountId = StudentId('123');
        final EmailAddress emailAddress = EmailAddress('invalidemail');
        final Password password = Password('password');
        const bool isVerified = true;
        StudentAuthInfo(
          accountId: accountId,
          emailAddress: emailAddress,
          password: password,
          isVerified: isVerified,
        );
      },
          throwsA(isA<StudentAuthCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              StudentAuthCreationExceptionDetail.invalidEmailFormat)));
    });
  });

  group('methods', () {
    test('change_email_address_with_valid_email', () {
      final StudentId accountId = StudentId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = true;

      final StudentAuthInfo account = StudentAuthInfo(
        accountId: accountId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      final EmailAddress newEmailAddress = EmailAddress('new@example.com');
      account.changeEmailAddress(newEmailAddress);

      expect(account.emailAddress, equals(newEmailAddress));
    });

    test('change_password_with_valid_password', () {
      final StudentId accountId = StudentId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = true;

      final StudentAuthInfo account = StudentAuthInfo(
        accountId: accountId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      final Password newPassword = Password('newpassword');
      account.changePassword(newPassword);

      expect(account.password, equals(newPassword));
    });

    test('change_email_address_with_invalid_email', () {
      final StudentId accountId = StudentId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = true;

      final StudentAuthInfo account = StudentAuthInfo(
        accountId: accountId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      expect(() {
        final EmailAddress newEmailAddress = EmailAddress('invalidemail');
        account.changeEmailAddress(newEmailAddress);
      },
          throwsA(isA<StudentAuthCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              StudentAuthCreationExceptionDetail.invalidEmailFormat)));
      expect(account.emailAddress, equals(emailAddress));
    });
  });
}
