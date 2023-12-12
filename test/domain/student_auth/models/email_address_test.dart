import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';
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
      expect(() => EmailAddress(email),
          throwsA(const TypeMatcher<DomainException>()));
    });

    test('without_at_character', () {
      const String email = 'testexample.com';
      expect(() => EmailAddress(email),
          throwsA(const TypeMatcher<DomainException>()));
    });

    test('multiple_at_characters', () {
      const String email = 'test@@example.com';
      expect(() => EmailAddress(email),
          throwsA(const TypeMatcher<DomainException>()));
    });

    test('no_at_sign', () {
      const String email = 'testexample.com';
      expect(() => EmailAddress(email),
          throwsA(const TypeMatcher<DomainException>()));
    });

    test('no_period_after_at_sign', () {
      const String email = 'test@examplecom';
      expect(() => EmailAddress(email),
          throwsA(const TypeMatcher<DomainException>()));
    });
  });
}
