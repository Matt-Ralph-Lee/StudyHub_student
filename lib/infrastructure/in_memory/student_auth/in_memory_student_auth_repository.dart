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
    streamControllers[studentId] = StreamController<StudentAuthInfo?>();

    final streamController = streamControllers[studentId]!;
    streamController.add(null);
  }

  @override
  void delete(final StudentId studentId) {
    signedInStore.remove(studentId);
    store.remove(studentId);
    emailToIdMap.removeWhere((email, id) => id == studentId);
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
    return _maskPassword(storedStudentAuth);
  }

  @override
  StudentAuthInfo? getAccountState(final StudentId studentId) {
    if (signedInStore[studentId] == null) {
      return null;
    }
    final storedStudentAuth = store[studentId];
    if (storedStudentAuth == null) {
      return null;
    }
    return _maskPassword(storedStudentAuth);
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
    streamControllers[studentId]!.add(_maskPassword(storedStudentAuthInfo));
  }

  @override
  void signOut(final StudentId studentId) {
    signedInStore[studentId] = false;
    streamControllers[studentId]!.add(null);
  }

  @override
  void sendPasswordResetEmail(EmailAddress emailAddress) {
    throw UnimplementedError();
  }

  @override
  void updatePassword(
      {required StudentId studentId,
      required Password currentPassword,
      required Password newPassword}) {
    final storedStudentAuth = _getById(studentId);
    if (storedStudentAuth == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notFound);
    }

    if (currentPassword != newPassword) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.wrongEmailOrPassword);
    }

    storedStudentAuth.changePassword(newPassword);
    store[studentId] = storedStudentAuth;
  }

  @override
  void updateEmailAddress(final StudentAuthInfo updatedStudentAuth) {
    final storedStudentAuth = _getById(updatedStudentAuth.studentId);
    if (storedStudentAuth == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notFound);
    }

    final password = storedStudentAuth.password!;
    updatedStudentAuth.changePassword(password);
    updatedStudentAuth.changeIsVerified(false);

    final oldEmailAddress = updatedStudentAuth.emailAddress;
    emailToIdMap.remove(oldEmailAddress);

    final studentId = updatedStudentAuth.studentId;
    final emailAddress = updatedStudentAuth.emailAddress;
    store[studentId] = updatedStudentAuth;
    emailToIdMap[emailAddress] = studentId;
    streamControllers[studentId]!.add(findById(studentId));
  }

  @override
  void verifyWithEmail(final StudentId studentId) {
    final studentAuthInfo = _getById(studentId);
    if (studentAuthInfo == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notFound);
    }
    studentAuthInfo.changeIsVerified(true);
    store[studentId] = studentAuthInfo;
    streamControllers[studentId]!.add(findById(studentId));
  }

  StudentAuthInfo _maskPassword(final StudentAuthInfo studentAuthInfo) {
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

  StudentAuthInfo? _getById(final StudentId studentId) {
    final data = store[studentId];
    if (data == null) {
      return null;
    }
    return _clone(data);
  }

  StudentAuthInfo _clone(final StudentAuthInfo studentAuthInfo) {
    return StudentAuthInfo(
      studentId: studentAuthInfo.studentId,
      emailAddress: studentAuthInfo.emailAddress,
      password: studentAuthInfo.password,
      isVerified: studentAuthInfo.isVerified,
    );
  }
}
