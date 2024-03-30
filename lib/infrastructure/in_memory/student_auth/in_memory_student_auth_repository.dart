import 'dart:async';

import '../../../application/student_auth/application_service/student_auth_info_without_password.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../../domain/student_auth/models/student_auth_info.dart';
import '../../exceptions/student_auth/student_auth_infrastructure_exception.dart';
import '../../exceptions/student_auth/student_auth_infrastructure_exception_detail.dart';

class InMemoryStudentAuthRepository implements IStudentAuthRepository {
  late int count;
  late Map<StudentId, StudentAuthInfo> store;
  late Map<EmailAddress, StudentId> emailToIdMap;
  // about current Student
  late StreamController<StudentAuthInfoWithoutPassword?> streamController;
  late StudentId? currentStudentId;

  static final InMemoryStudentAuthRepository _instance =
      InMemoryStudentAuthRepository._internal();

  factory InMemoryStudentAuthRepository() {
    return _instance;
  }

  InMemoryStudentAuthRepository._internal() {
    count = 10000;
    store = {};
    emailToIdMap = {};
    streamController = StreamController<StudentAuthInfoWithoutPassword?>();
    currentStudentId = null;
  }

  @override
  Future<void> createWithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  }) async {
    if (emailToIdMap.containsKey(emailAddress)) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.emailAddressAlreadyInUse);
    }
    final studentId =
        StudentId(count.toString().padLeft(StudentId.minLength + 10, '0'));
    final studentAuthInfo = StudentAuthInfo(
      studentId: studentId,
      emailAddress: emailAddress,
      password: password,
      isVerified: false,
    );

    currentStudentId = studentId;
    store[studentId] = studentAuthInfo;
    emailToIdMap[emailAddress] = studentId;

    streamController.add(StudentAuthInfoWithoutPassword(
      studentId: studentId,
      emailAddress: emailAddress,
      isVerified: false,
    ));

    count++;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (currentStudentId == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notSignedIn);
    }
    final studentAuth = store[currentStudentId];
    if (studentAuth == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected);
    }
    studentAuth.changeIsVerified(true);

    streamController.sink.add(StudentAuthInfoWithoutPassword(
      studentId: studentAuth.studentId,
      emailAddress: studentAuth.emailAddress,
      isVerified: studentAuth.isVerified,
    ));
  }

  @override
  Future<void> delete() async {
    store.remove(currentStudentId);
    emailToIdMap.removeWhere((email, id) => id == currentStudentId);
    currentStudentId = null;
    streamController.add(null);
  }

  @override
  Future<void> updateEmailAddress(final EmailAddress newEmailAddress) async {
    if (currentStudentId == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notSignedIn);
    }
    final studentAuthInfo = store[currentStudentId];
    if (studentAuthInfo == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected);
    }
    final oldEmailAddress = studentAuthInfo.emailAddress;
    studentAuthInfo.changeEmailAddress(newEmailAddress);
    emailToIdMap[newEmailAddress] = studentAuthInfo.studentId;
    emailToIdMap.remove(oldEmailAddress);
  }

  @override
  Future<void> sendPasswordResetEmail(
      {required final EmailAddress emailAddress}) async {
    if (emailToIdMap[emailAddress] == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.studentNotFound);
    }
  }

  @override
  Future<void> signIn({
    required final EmailAddress emailAddress,
    required final Password password,
  }) async {
    final storedStudentAuthInfo = _getByEmailAddress(emailAddress);

    if (storedStudentAuthInfo == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.studentNotFound);
    }

    if (password != storedStudentAuthInfo.password) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.wrongPassword);
    }

    final studentId = storedStudentAuthInfo.studentId;
    currentStudentId = studentId;
    streamController.add(StudentAuthInfoWithoutPassword(
      studentId: studentId,
      emailAddress: emailAddress,
      isVerified: storedStudentAuthInfo.isVerified,
    ));
  }

  @override
  Future<void> signOut() async {
    if (currentStudentId == null) {
      return;
    }
    currentStudentId = null;
    streamController.add(null);
  }

  StudentAuthInfo? _getByEmailAddress(final EmailAddress emailAddress) {
    final studentId = emailToIdMap[emailAddress];
    return studentId == null ? null : store[studentId];
  }

  @override
  StudentId? getStudentIdSnapshot() {
    return currentStudentId;
  }
}
