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
  void update(final StudentAuthInfo account);
  void resetPassword(final EmailAddress emailAddress);
  void verify(final EmailAddress emailAddress);
  StudentAuthInfo? getCurrentAccount();
  Stream<StudentAuthInfo?> accountState();
  StudentAuthInfo? findById(final StudentId studentId);
  StudentAuthInfo? findByEmailAddress(final EmailAddress emailAddress);
}
