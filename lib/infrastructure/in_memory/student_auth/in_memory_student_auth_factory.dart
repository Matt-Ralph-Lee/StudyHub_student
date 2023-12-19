import 'package:uuid/uuid.dart';

import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_factory.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../../domain/student_auth/models/student_auth_info.dart';

class InMemoryStudentAuthFactory implements IStudentAuthFactory {
  @override
  StudentAuthInfo createWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password}) {
    return StudentAuthInfo(
      studentId: StudentId(const Uuid().v4()),
      emailAddress: emailAddress,
      password: password,
      isVerified: false,
    );
  }
}
