import 'package:studyhub/infrastructure/in_memory/student_auth/exception/student_auth_infrastructure_exception.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/exception/student_auth_infrastructure_exception_detail.dart';

import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../../domain/student_auth/models/student_auth_info.dart';

class InMemoryStudentAuthRepository implements IStudentAuthRepository {
  final store = <StudentId, StudentAuthInfo>{};
  final emailToIdMap = <EmailAddress, StudentId>{};

  @override
  Stream<StudentAuthInfo?> accountState(final StudentId studentId) {
    // TODO: implement accountState
    throw UnimplementedError();
  }

  @override
  void create(final StudentAuthInfo studentAuthInfo) {
    final studentId = studentAuthInfo.studentId;
    final emailAddress = studentAuthInfo.emailAddress;
    store[studentId] = studentAuthInfo;
    emailToIdMap[emailAddress] = studentId;
  }

  @override
  void delete(final StudentId studentId) {
    store.remove(studentId);
    emailToIdMap.removeWhere((email, id) => id == studentId);
  }

  @override
  StudentAuthInfo? findByEmailAddress(final EmailAddress emailAddress) {
    final studentId = emailToIdMap[emailAddress];
    if (studentId == null) {
      return null;
    }
    return store[studentId];
  }

  @override
  StudentAuthInfo? findById(final StudentId studentId) => store[studentId];

  @override
  StudentAuthInfo? getCurrentAccount(final StudentId studentId) {
    // TODO: implement getCurrentAccount
    throw UnimplementedError();
  }

  @override
  void resetPassword(final EmailAddress emailAddress) {
    // TODO: implement resetPassword
  }

  @override
  void signIn(
      {required final EmailAddress emailAddress,
      required final Password password}) {
    // TODO: implement signIn
  }

  @override
  void signOut(final StudentId studentId) {
    // TODO: implement signOut
  }

  @override
  void update(final StudentAuthInfo studentAuthInfo) {
    final storedStudentAuthInfo = findById(studentAuthInfo.studentId);
    if (storedStudentAuthInfo == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notFound);
    }
    final storedPassword = storedStudentAuthInfo.password;
    // studentAuth
    studentAuthInfo.changePassword(storedPassword);

  }

  @override
  void verifyWithEmail(final StudentId studentId) {
    final studentAuthInfo = findById(studentId);
    if (studentAuthInfo == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notFound);
    }
    studentAuthInfo.changeIsVerified(true);
    store[studentId] = studentAuthInfo;
  }
}
