import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/argument_exception/argument_exception.dart';
import 'package:studyhub/common/exception/argument_exception/argument_exception_detail.dart';
import 'package:studyhub/domain/account_for_student/models/email_address.dart';

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
          throwsA(isA<ArgumentException>().having((e) => e.exceptionDetail,
              'detail', equals(ArgumentExceptionDetail.emptyException))));
    });

    test('without_at_character', () {
      const String email = 'testexample.com';
      expect(
          () => EmailAddress(email),
          throwsA(isA<ArgumentException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(ArgumentExceptionDetail.invalidCharacterException))));
    });

    test('multiple_at_characters', () {
      const String email = 'test@@example.com';
      expect(
          () => EmailAddress(email),
          throwsA(isA<ArgumentException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(ArgumentExceptionDetail.invalidCharacterException))));
    });

    test('no_at_sign', () {
      const String email = 'testexample.com';
      expect(
          () => EmailAddress(email),
          throwsA(isA<ArgumentException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(ArgumentExceptionDetail.invalidCharacterException))));
    });

    test('no_period_after_at_sign', () {
      const String email = 'test@examplecom';
      expect(
          () => EmailAddress(email),
          throwsA(isA<ArgumentException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(ArgumentExceptionDetail.invalidCharacterException))));
    });
  });

  group('method', () {
    test('should_be_equal_with_same_email_address', () {
      const String email = 'test@example.com';
      final emailAddress1 = EmailAddress(email);
      final emailAddress2 = EmailAddress(email);
      expect(emailAddress1, equals(emailAddress2));
    });
  });
}
