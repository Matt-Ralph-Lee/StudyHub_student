import 'package:firebase_auth/firebase_auth.dart';

import '../../../application/student_auth/application_service/i_get_student_auth_query_service.dart';
import '../../../application/student_auth/application_service/student_auth_info_without_password.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';

class FirebaseGetStudentAuthQueryService
    implements IGetStudentAuthQueryService {
  final FirebaseAuth _firebaseAuth;

  FirebaseGetStudentAuthQueryService({required final FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Stream<StudentAuthInfoWithoutPassword?> userChanges() {
    return _firebaseAuth.userChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }
      return StudentAuthInfoWithoutPassword(
        studentId: StudentId(firebaseUser.uid),
        emailAddress: EmailAddress(firebaseUser.email!),
        isVerified: firebaseUser.emailVerified,
      );
    });
  }
}
