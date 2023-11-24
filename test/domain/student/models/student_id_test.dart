import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/student_exception/student_creation_exception.dart';
import 'package:studyhub/common/exception/student_exception/student_creation_exception_detail.dart';
import 'package:studyhub/domain/student/models/student_id.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('not_throw_exception', () {
      final userId = StudentId('abc');
      expect(() => userId, returnsNormally);
    });

    test('should_be_equal_to_constructor_value', () {
      final userId = StudentId('abc');
      expect(userId.value, equals('abc'));
    });

    test('empty_string_value', () {
      expect(
          () => StudentId(''),
          throwsA(isA<StudentCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              StudentCreationExceptionDetail.empty)));
    });
  });
}
