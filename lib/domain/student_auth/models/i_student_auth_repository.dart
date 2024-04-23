import '../../student/models/student_id.dart';
import 'email_address.dart';
import 'password.dart';

abstract class IStudentAuthRepository {
  Future<void> createWithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  });
  Future<void> sendEmailVerification();
  Future<void> delete();
  Future<void> updateEmailAddress(final EmailAddress emailAddress);
  Future<void> sendPasswordResetEmail(
      {required final EmailAddress emailAddress});
  Future<void> signIn({
    required final EmailAddress emailAddress,
    required final Password password,
  });
  Future<void> signOut();
  StudentId? getStudentIdSnapshot();

  Future<void> reloadUser();
}
