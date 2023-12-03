import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/student/models/student.dart';
import 'package:studyhub/domain/student/models/email_address.dart';
import 'package:studyhub/domain/account/models/account_id.dart';

void main() {
  setUp(() => null);
  group('constructor', () {
    test('valid_userId_and_emailAddress', () {
      final AccountId userId = AccountId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');

      final Student account =
          Student(studentId: userId, emailAddress: emailAddress);

      expect(account.accountId, equals(userId));
      expect(account.emailAddress, equals(emailAddress));
    });
  });

  group('logics', () {
    test('test_changeEmailAddress', () {
      final AccountId userId = AccountId('123');
      final EmailAddress emailAddress = EmailAddress('test@example.com');
      final Student account =
          Student(studentId: userId, emailAddress: emailAddress);

      final newEmailAddress = EmailAddress('new@example.com');
      account.changeEmailAddress(newEmailAddress);

      expect(account.emailAddress, equals(newEmailAddress));
    });
  });
}
