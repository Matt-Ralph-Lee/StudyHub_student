import 'dart:async';

import '../../../application/student_auth/application_service/student_auth_info_without_password.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../../domain/student_auth/models/student_auth_info.dart';
import '../../exceptions/student_auth/student_auth_infrastructure_exception.dart';
import '../../exceptions/student_auth/student_auth_infrastructure_exception_detail.dart';
import '../student/in_memory_student_repository.dart';

class InMemoryStudentAuthRepository implements IStudentAuthRepository {
  late int count;
  late Map<StudentId, StudentAuthInfo> store;
  late Map<EmailAddress, StudentId> emailToIdMap;
  late StreamController<StudentAuthInfoWithoutPassword?> streamController;
  late StudentId? currentStudentId;

  static final InMemoryStudentAuthRepository _instance =
      InMemoryStudentAuthRepository._internal();

  factory InMemoryStudentAuthRepository() {
    return _instance;
  }

  InMemoryStudentAuthRepository._internal() {
    count = 10000;
    store = {
      InMemoryStudentAuthInitialValue.studentAuth1.studentId:
          InMemoryStudentAuthInitialValue.studentAuth1,
      InMemoryStudentAuthInitialValue.studentAuth2.studentId:
          InMemoryStudentAuthInitialValue.studentAuth2,
      InMemoryStudentAuthInitialValue.studentAuth3.studentId:
          InMemoryStudentAuthInitialValue.studentAuth3,
    };
    emailToIdMap = {
      InMemoryStudentAuthInitialValue.studentAuth1.emailAddress:
          InMemoryStudentAuthInitialValue.studentAuth1.studentId,
      InMemoryStudentAuthInitialValue.studentAuth2.emailAddress:
          InMemoryStudentAuthInitialValue.studentAuth2.studentId,
      InMemoryStudentAuthInitialValue.studentAuth3.emailAddress:
          InMemoryStudentAuthInitialValue.studentAuth3.studentId,
    };
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

  @override
  Future<void> reloadUser() async {}

  @override
  Future<void> registerToken({
    required EmailAddress? emailAddress,
    required StudentId? studentId,
  }) async {}
}

class InMemoryStudentAuthInitialValue {
  static final studentAuth1 = StudentAuthInfo(
      studentId: InMemoryStudentInitialValue.student1.studentId,
      emailAddress: EmailAddress('student1@example.com'),
      password: Password('student1'),
      isVerified: true);
  static final studentAuth2 = StudentAuthInfo(
      studentId: InMemoryStudentInitialValue.student2.studentId,
      emailAddress: EmailAddress('student2@example.com'),
      password: Password('student2'),
      isVerified: true);
  static final studentAuth3 = StudentAuthInfo(
      studentId: InMemoryStudentInitialValue.student3.studentId,
      emailAddress: EmailAddress('student3@example.com'),
      password: Password('student3'),
      isVerified: true);
}
