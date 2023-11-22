import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/argument_exception/argument_exception.dart';
import 'package:studyhub/common/exception/argument_exception/argument_exception_detail.dart';
import 'package:studyhub/domain/account_for_student/models/user_id.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('not_throw_exception', () {
      final userId = UserId('abc');
      expect(() => userId, returnsNormally);
    });

    test('should_be_equal_to_constructor_value', () {
      final userId = UserId('abc');
      expect(userId.value, equals('abc'));
    });

    test('empty_string_value', () {
      expect(
          () => UserId(''),
          throwsA(isA<ArgumentException>().having((e) => e.exceptionDetail,
              'detail', ArgumentExceptionDetail.emptyException)));
    });
  });
}
