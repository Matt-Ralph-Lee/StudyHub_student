import 'email_address.dart';
import 'password.dart';
import 'student_auth_info.dart';

abstract class IStudentAuthFactory {
  Future<StudentAuthInfo> createWithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  });
}
