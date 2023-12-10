import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('valid_non_empty_string_value', () {
      const String value = 'password';
      final Password password = Password(value);
      expect(() => password, returnsNormally);
    });

    test('equal_to_minLength', () {
      const String value = '123456';
      final Password password = Password(value);
      expect(() => password, returnsNormally);
    });

    test('less_than_minLength', () {
      const String value = '123';
      expect(
          () => Password(value), throwsA(const TypeMatcher<DomainException>()));
    });

    test('more_than_maximumLength', () {
      const String value =
          'passwordpasswordpasswordpasswordpasswordpasswordpasswordpasswordpasswordpasswordpasswordpasswordpasswordpasswordpasswordpassword';
      expect(
          () => Password(value), throwsA(const TypeMatcher<DomainException>()));
    });

    test('empty_string_value', () {
      const String value = '';
      expect(
          () => Password(value), throwsA(const TypeMatcher<DomainException>()));
    });
  });
}
