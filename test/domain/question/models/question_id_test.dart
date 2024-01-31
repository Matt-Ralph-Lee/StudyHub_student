import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/question/models/question_id.dart';
import 'package:studyhub/domain/shared/domain_exception.dart';

void main() {
  group('constructor', () {
    test('not_throw_exception', () {
      final questionId = QuestionId('01234567890123456789');
      expect(() => questionId, returnsNormally);
    });

    test('should_be_equal_to_contructor_value', () {
      final questionId = QuestionId('01234567890123456789');
      expect(questionId.value, equals('01234567890123456789'));
    });

    test('empty_string_value', () {
      expect(
          () => QuestionId(''), throwsA(const TypeMatcher<DomainException>()));
    });
  });
}
