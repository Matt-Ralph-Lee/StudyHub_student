import 'student_auth_info_without_password.dart';

abstract class IGetStudentAuthQueryService {
  Stream<StudentAuthInfoWithoutPassword?> userChanges();
}
