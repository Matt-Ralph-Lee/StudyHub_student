import 'student_auth_info.dart';
import '../../student/models/student_id.dart';
import 'email_address.dart';
import 'password.dart';

abstract class IStudentAuthRepository {
  void create(final StudentAuthInfo studentAuthInfo);
  void signIn({
    required final EmailAddress emailAddress,
    required final Password password,
  });
  void signOut(final StudentId studentId);
  void delete(final StudentId studentId);
  void updateEmailAddress(final StudentAuthInfo updatedStudentAuthInfo);
  void updatePassword({
    required final StudentId studentId,
    required final Password currentPassword,
    required final Password newPassword,
  });
  void sendPasswordResetEmail(final EmailAddress emailAddress);
  void verifyWithEmail(final StudentId studentId);
  StudentAuthInfo? getAccountState(final StudentId studentId);
  Stream<StudentAuthInfo?> accountState(final StudentId studentId);
  StudentAuthInfo? findById(final StudentId studentId);
  StudentAuthInfo? findByEmailAddress(final EmailAddress emailAddress);
}
