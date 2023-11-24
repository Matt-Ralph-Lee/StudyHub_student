import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/student_exception/student_creation_exception.dart';
import 'package:studyhub/common/exception/student_exception/student_creation_exception_detail.dart';
import 'package:studyhub/domain/student/models/password.dart';

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
          throwsA(isA<StudentCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(StudentCreationExceptionDetail.weakPassword))));
    });

    test('empty_string_value', () {
      const String value = '';
      expect(
          () => Password(value),
          throwsA(isA<StudentCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              equals(StudentCreationExceptionDetail.empty))));
    });
  });
}
