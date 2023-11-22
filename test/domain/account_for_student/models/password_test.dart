import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/argument_exception/argument_exception.dart';
import 'package:studyhub/common/exception/argument_exception/argument_exception_detail.dart';
import 'package:studyhub/common/exception/password_exception/password_exception.dart';
import 'package:studyhub/common/exception/password_exception/password_exception_detail.dart';
import 'package:studyhub/domain/account_for_student/models/password.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('valid_non_empty_string_value', () {
      const String value = 'password';
      final Password password = Password(value);
      expect(password.value, equals(value));
    });

    test('equal_to_minLength', () {
      const String value = '123456';
      final Password password = Password(value);
      expect(password.value, equals(value));
    });

    test('less_than_minLength', () {
      const String value = '123';
      expect(
          () => Password(value),
          throwsA(isA<PasswordException>().having((e) => e.exceptionDetail,
              'detail', equals(PasswordExceptionDetail.shortException))));
    });

    test('empty_string_value', () {
      const String value = '';
      expect(
          () => Password(value),
          throwsA(isA<ArgumentException>().having((e) => e.exceptionDetail,
              'detail', equals(ArgumentExceptionDetail.emptyException))));
    });
  });
}
