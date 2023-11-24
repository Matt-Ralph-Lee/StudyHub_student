import 'student.dart';
import 'email_address.dart';
import 'password.dart';

abstract class IStudentRepository {
  Future<void> create({
    required final EmailAddress emailAddress,
    required final Password password,
  });
  Future<void> signIn({
    required final EmailAddress emailAddress,
    required final Password password,
  });
  Future<void> signOut();
  Future<void> delete();
  Stream<Student?> accountStateChanges();
  Student? getCurrentAccount();
  Stream<bool> isSignedIn();
  Student? findByEmailAddress(final EmailAddress emailAddress);
  Future<void> resetPassword({
    required final Student account,
    required Password newPassword,
  });
  Future<void> saveChangedEmailAddress(final Student modifiedAccount);
}
