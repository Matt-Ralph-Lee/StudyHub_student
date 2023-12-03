import 'package:studyhub/domain/account/models/account_id.dart';

import 'student.dart';
import 'email_address.dart';
import '../../account/password.dart';

abstract class IStudentRepository {
  Future<void> save(final Student student);

  Future<void> delete();
  Stream<Student?> accountStateChanges();
  Student? getCurrentAccount();
  Stream<bool> isSignedIn();
  Student? findByEmailAddress(final EmailAddress emailAddress);
  Student? findById(final AccountId studentId);
  Future<void> resetPassword({
    required final Student account,
    required Password newPassword,
  });
  Future<void> saveChangedEmailAddress(final Student modifiedAccount);
}
