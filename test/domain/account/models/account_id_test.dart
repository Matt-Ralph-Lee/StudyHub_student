import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/common/exception/account/account_creation_exception.dart';
import 'package:studyhub/common/exception/account/account_creation_exception_detail.dart';
import 'package:studyhub/domain/account/models/account_id.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('not_throw_exception', () {
      final accountId = AccountId('abc');
      expect(() => accountId, returnsNormally);
    });

    test('should_be_equal_to_constructor_value', () {
      final userId = AccountId('abc');
      expect(userId.value, equals('abc'));
    });

    test('empty_string_value', () {
      expect(
          () => AccountId(''),
          throwsA(isA<AccountCreationException>().having(
              (e) => e.exceptionDetail,
              'detail',
              AccountCreationExceptionDetail.empty)));
    });
  });
}