import 'package:firebase_auth/firebase_auth.dart';
import 'package:studyhub/application/account/account_dto.dart';
import 'package:studyhub/common/exception/student_auth/student_auth_process_exception.dart';
import 'package:studyhub/common/exception/student_auth/student_auth_process_exception_detail.dart';
import 'package:studyhub/domain/student_auth/models/student_auth_info.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';

import '../../../common/exception/student/student_creation_exception.dart';
import '../../../common/exception/student/student_creation_exception_detail.dart';
import '../../../common/exception/student/student_process_exception.dart';
import '../../../common/exception/student/student_process_exception_detail.dart';
import '../../../common/exception/unknown_exception.dart';
import '../../../common/exception/unknown_exception_detail.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/student/models/email_address.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/account/password.dart';

class FirebaseAccountRepository implements IStudentAuthRepository {
  @override
  void create(StudentAuthInfo account) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: account.emailAddress.value,
        password: account.password.value,
      );
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }

  }

  @override
  void signIn(
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
  Future<void> delete() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw const StudentAuthProcessException(
          StudentAuthProcessExceptionDetail.noCurrentAccount);
    }
    try {
      await currentUser.delete();
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  @override
  void updateEmailAddress(EmailAddress emailAddress) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw const StudentAuthProcessException(
          StudentAuthProcessExceptionDetail.noCurrentAccount);
    }
    try {
      await currentUser.updateEmail(emailAddress.value);
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  @override
  void updatePassword(Password newPassword) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw const StudentAuthProcessException(
          StudentAuthProcessExceptionDetail.noCurrentAccount);
    }
    try {
      await currentUser.updatePassword(newPassword.value);
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  @override
  void resetPassword(EmailAddress emailAddress) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAddress.value);
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  @override
  Stream<AccountDto?> accountState() {
    final user = FirebaseAuth.instance.currentUser;
    return _userToAccountDto(user);
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

  // Firebaseでは、create時にemailAddressのチェックを行うため、ここではチェックを行わない。
  @override
  Student? findByEmailAddress(EmailAddress emailAddress) => null;


  @override
  Stream<bool> isSignedIn() {
    return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
  }

  AccountDto? _userToAccountDto(final User? user) {
    if (user == null) {
      return null;
    }
    if (user.email == null) {
      return null;
    }
    // TODO: AccountとStudentの対応表が必要？
    final studentId = ;
    return AccountDto(emailAddress: user.email!, studentId: studentId);
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
