import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/account/account_creation_exception.dart';
import 'package:studyhub/common/exception/account/account_creation_exception_detail.dart';
import 'package:studyhub/domain/account/models/email_address.dart';

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
          throwsA(isA<AccountCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(AccountCreationExceptionDetail.empty))));
    });

    test('without_at_character', () {
      const String email = 'testexample.com';
      expect(
          () => EmailAddress(email),
          throwsA(isA<AccountCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(AccountCreationExceptionDetail.invalidEmailFormat))));
    });

    test('multiple_at_characters', () {
      const String email = 'test@@example.com';
      expect(
          () => EmailAddress(email),
          throwsA(isA<AccountCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(AccountCreationExceptionDetail.invalidEmailFormat))));
    });

    test('no_at_sign', () {
      const String email = 'testexample.com';
      expect(
          () => EmailAddress(email),
          throwsA(isA<AccountCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(AccountCreationExceptionDetail.invalidEmailFormat))));
    });

    test('no_period_after_at_sign', () {
      const String email = 'test@examplecom';
      expect(
          () => EmailAddress(email),
          throwsA(isA<AccountCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(AccountCreationExceptionDetail.invalidEmailFormat))));
    });
  });
}
