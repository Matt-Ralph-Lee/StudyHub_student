import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/exception/student/student_creation_exception.dart';
import '../../../common/exception/student/student_creation_exception_detail.dart';
import '../../../common/exception/student/student_process_exception.dart';
import '../../../common/exception/student/student_process_exception_detail.dart';
import '../../../common/exception/unknown_exception.dart';
import '../../../common/exception/unknown_exception_detail.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/student/models/email_address.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/account/password.dart';

class FirebaseStudentRepository implements IAccountRepository {
  @override
  Stream<Student?> accountStateChanges() {
    return FirebaseAuth.instance
        .authStateChanges()
        .map((user) => _userToAccount(user));
  }

  @override
  Future<void> saveChangedEmailAddress(Student modifiedAccount) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw const StudentProcessException(
          StudentProcessExceptionDetail.noCurrentStudent);
    }
    try {
      await currentUser.updateEmail(modifiedAccount.emailAddress.value);
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  @override
  Future<void> create({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress.value,
        password: password.value,
      );
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  @override
  Future<void> delete() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw const StudentProcessException(
          StudentProcessExceptionDetail.noCurrentStudent);
    }
    try {
      await currentUser.delete();
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  // Firebaseでは、create時にemailAddressのチェックを行うため、ここではチェックを行わない。
  @override
  Student? findByEmailAddress(EmailAddress emailAddress) => null;

  @override
  Student? getCurrentAccount() {
    final user = FirebaseAuth.instance.currentUser;
    return _userToAccount(user);
  }

  @override
  Stream<bool> isSignedIn() {
    return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
  }

  @override
  Future<void> signIn(
      {required EmailAddress emailAddress, required Password password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress.value,
        password: password.value,
      );
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  @override
  Future<void> resetPassword({
    required Student account,
    required Password newPassword,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw const StudentProcessException(
          StudentProcessExceptionDetail.noCurrentStudent);
    }
    try {
      await currentUser.updatePassword(newPassword.value);
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  Student? _userToAccount(final User? user) {
    if (user == null) {
      return null;
    }
    if (user.email == null) {
      return null;
    }
    final accountId = StudentId(user.uid);
    final emailAddress = EmailAddress(user.email!);
    final account = Student(studentId: accountId, emailAddress: emailAddress);
    return account;
  }

  void _processFirebaseAuthException(final FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      throw const StudentCreationException(
          StudentCreationExceptionDetail.weakPassword);
    } else if (e.code == 'email-already-in-use') {
      throw const StudentCreationException(
          StudentCreationExceptionDetail.alreadyExists);
    } else if (e.code == 'user-not-found') {
      throw const StudentProcessException(
          StudentProcessExceptionDetail.notFound);
    } else if (e.code == 'wrong-password') {
      throw const StudentProcessException(
          StudentProcessExceptionDetail.wrongPassword);
    }
  }
}
