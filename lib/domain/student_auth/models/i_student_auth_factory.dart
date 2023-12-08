import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';

import 'student_auth_info.dart';

abstract class IStudentAuthFactory {
  StudentAuthInfo createWithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  });
}
