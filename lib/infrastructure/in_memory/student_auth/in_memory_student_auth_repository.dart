import 'dart:async';

import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../../domain/student_auth/models/student_auth_info.dart';
import 'exception/student_auth_infrastructure_exception.dart';
import 'exception/student_auth_infrastructure_exception_detail.dart';

class InMemoryStudentAuthRepository implements IStudentAuthRepository {
  final signedInStore = <StudentId, bool>{};
  final store = <StudentId, StudentAuthInfo>{};
  final emailToIdMap = <EmailAddress, StudentId>{};
  final streamControllers = <StudentId, StreamController<StudentAuthInfo?>>{};

  @override
  Stream<StudentAuthInfo?> accountState(final StudentId studentId) {
    final streamController = streamControllers[studentId];
    if (streamController == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notFound);
    }
    return streamController.stream;
  }

  @override
  void create(final StudentAuthInfo studentAuthInfo) {
    if (studentAuthInfo.password == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.noPassword);
    }
    final studentId = studentAuthInfo.studentId;
    final emailAddress = studentAuthInfo.emailAddress;

    signedInStore[studentId] = false;
    store[studentId] = studentAuthInfo;
    emailToIdMap[emailAddress] = studentId;
    streamControllers[studentId] = StreamController<StudentAuthInfo>();

    final streamController = streamControllers[studentId]!;
    streamController.add(studentAuthInfo);
  }

  @override
  void delete(final StudentId studentId) {
    signedInStore.remove(studentId);
    store.remove(studentId);
    emailToIdMap.removeWhere((email, id) => id == studentId);
    streamControllers[studentId]!.add(null);
    streamControllers.remove(studentId);
  }

  @override
  StudentAuthInfo? findByEmailAddress(final EmailAddress emailAddress) {
    final studentId = emailToIdMap[emailAddress];
    if (studentId == null) {
      return null;
    }
    return findById(studentId);
  }

  @override
  StudentAuthInfo? findById(final StudentId studentId) {
    final storedStudentAuth = store[studentId];
    if (storedStudentAuth == null) {
      return null;
    }
    return _passwordMasked(storedStudentAuth);
  }

  @override
  StudentAuthInfo? getCurrentAccount(final StudentId studentId) {
    if (signedInStore[studentId] == null) {
      return null;
    }
    final storedStudentAuth = store[studentId];
    if (storedStudentAuth == null) {
      return null;
    }
    return _passwordMasked(storedStudentAuth);
  }

  @override
  void signIn(
      {required final EmailAddress emailAddress,
      required final Password password}) {
    final storedStudentAuthInfo = _getByEmailAddress(emailAddress);

    if (storedStudentAuthInfo == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.wrongEmailOrPassword);
    }

    final storedPassword = storedStudentAuthInfo.password;
    if (password != storedPassword) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.wrongEmailOrPassword);
    }

    final studentId = storedStudentAuthInfo.studentId;
    signedInStore[studentId] = true;
    streamControllers[studentId]!.add(storedStudentAuthInfo);
  }

  @override
  void signOut(final StudentId studentId) {
    signedInStore[studentId] = false;
    streamControllers[studentId]!.add(null);
  }

  @override
  void update(final StudentAuthInfo updatedStudentAuth) {
    final Password password;

    final storedStudentAuth = findById(updatedStudentAuth.studentId);
    if (storedStudentAuth == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notFound);
    }
    // password を変更しないとき
    if (updatedStudentAuth.password == null) {
      password = storedStudentAuth.password!;
      updatedStudentAuth.changePassword(password);
    }

    final oldEmailAddress = updatedStudentAuth.emailAddress;
    emailToIdMap.remove(oldEmailAddress);

    final studentId = updatedStudentAuth.studentId;
    final emailAddress = updatedStudentAuth.emailAddress;
    store[studentId] = updatedStudentAuth;
    emailToIdMap[emailAddress] = studentId;
    streamControllers[studentId]!.add(_getById(studentId));
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
    streamControllers[studentId]!.add(_getById(studentId));
  }

  StudentAuthInfo _passwordMasked(final StudentAuthInfo studentAuthInfo) {
    return StudentAuthInfo(
      studentId: studentAuthInfo.studentId,
      emailAddress: studentAuthInfo.emailAddress,
      password: null,
      isVerified: studentAuthInfo.isVerified,
    );
  }

  StudentAuthInfo? _getByEmailAddress(final EmailAddress emailAddress) {
    final studentId = emailToIdMap[emailAddress];
    if (studentId == null) {
      return null;
    }
    return _getById(studentId);
  }

  StudentAuthInfo? _getById(final StudentId studentId) => store[studentId];

  @override
  void sendPasswordResetEmail(EmailAddress emailAddress) {
    throw UnimplementedError();
  }
}
