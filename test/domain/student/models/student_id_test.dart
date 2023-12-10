import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';
import 'package:studyhub/domain/student/models/student_id.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('not_throw_exception', () {
      final accountId = StudentId('01234567890123456789');
      expect(() => accountId, returnsNormally);
    });

    test('should_be_equal_to_constructor_value', () {
      final userId = StudentId('01234567890123456789');
      expect(userId.value, equals('abc'));
    });

    test('empty_string_value', () {
      expect(
          () => StudentId(''), throwsA(const TypeMatcher<DomainException>()));
    });
  });
}
