import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';
import 'package:studyhub/domain/student_auth/models/student_auth_info.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('with_valid_inputs', () {
      final StudentId studentId = StudentId('01234567890123456789');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = false;

      final StudentAuthInfo account = StudentAuthInfo(
        studentId: studentId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      expect(() => account, returnsNormally);
    });

    test('with_invalid_email', () {
      expect(() {
        final StudentId studentId = StudentId('01234567890123456789');
        final EmailAddress emailAddress = EmailAddress('invalidemail');
        final Password password = Password('password');
        const bool isVerified = true;
        StudentAuthInfo(
          studentId: studentId,
          emailAddress: emailAddress,
          password: password,
          isVerified: isVerified,
        );
      }, throwsA(const TypeMatcher<DomainException>()));
    });
  });

  group('methods', () {
    test('change_email_address_with_valid_email', () {
      final StudentId studentId = StudentId('01234567890123456789');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = true;

      final StudentAuthInfo account = StudentAuthInfo(
        studentId: studentId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      final EmailAddress newEmailAddress = EmailAddress('new@example.com');
      account.changeEmailAddress(newEmailAddress);

      expect(account.emailAddress, equals(newEmailAddress));
    });

    test('change_password_with_valid_password', () {
      final StudentId studentId = StudentId('01234567890123456789');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = true;

      final StudentAuthInfo account = StudentAuthInfo(
        studentId: studentId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      final Password newPassword = Password('newpassword');
      account.changePassword(newPassword);

      expect(account.password, equals(newPassword));
    });

    test('change_email_address_with_invalid_email', () {
      final StudentId studentId = StudentId('01234567890123456789');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = true;

      final StudentAuthInfo account = StudentAuthInfo(
        studentId: studentId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      expect(() {
        final EmailAddress newEmailAddress = EmailAddress('invalidemail');
        account.changeEmailAddress(newEmailAddress);
      }, throwsA(const TypeMatcher<DomainException>()));
      expect(account.emailAddress, equals(emailAddress));
    });
  });
}
