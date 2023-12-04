import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/account/account_creation_exception.dart';
import 'package:studyhub/common/exception/account/account_creation_exception_detail.dart';
import 'package:studyhub/domain/account/models/account.dart';
import 'package:studyhub/domain/account/models/account_id.dart';
import 'package:studyhub/domain/account/models/email_address.dart';
import 'package:studyhub/domain/account/models/password.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('with_valid_inputs', () {
      final AccountId accountId = AccountId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = false;

      final Account account = Account(
        accountId: accountId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      expect(() => account, returnsNormally);
    });

    test('with_invalid_email', () {
      expect(() {
        final AccountId accountId = AccountId('123');
        final EmailAddress emailAddress = EmailAddress('invalidemail');
        final Password password = Password('password');
        const bool isVerified = true;
        Account(
          accountId: accountId,
          emailAddress: emailAddress,
          password: password,
          isVerified: isVerified,
        );
      },
          throwsA(isA<AccountCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              AccountCreationExceptionDetail.invalidEmailFormat)));
    });
  });

  group('methods', () {
    test('change_email_address_with_valid_email', () {
      final AccountId accountId = AccountId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = true;

      final Account account = Account(
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
      final AccountId accountId = AccountId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = true;

      final Account account = Account(
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
      final AccountId accountId = AccountId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Password password = Password('password');
      const bool isVerified = true;

      final Account account = Account(
        accountId: accountId,
        emailAddress: emailAddress,
        password: password,
        isVerified: isVerified,
      );

      expect(() {
        final EmailAddress newEmailAddress = EmailAddress('invalidemail');
        account.changeEmailAddress(newEmailAddress);
      },
          throwsA(isA<AccountCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              AccountCreationExceptionDetail.invalidEmailFormat)));
      expect(account.emailAddress, equals(emailAddress));
    });
  });
}
