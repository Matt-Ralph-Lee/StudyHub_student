import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/exception/account_exception/account_creation_exception.dart';
import '../../../common/exception/account_exception/account_creation_exception_detail.dart';
import '../../../common/exception/account_exception/account_process_exception.dart';
import '../../../common/exception/account_exception/account_process_exception_detail.dart';
import '../../../common/exception/unknown_exception.dart';
import '../../../common/exception/unknown_exception_detail.dart';
import '../../../domain/account_for_student/models/account.dart';
import '../../../domain/account_for_student/models/account_id.dart';
import '../../../domain/account_for_student/models/email_address.dart';
import '../../../domain/account_for_student/models/i_account_repository.dart';
import '../../../domain/account_for_student/models/password.dart';

class FireBaseAccountRepository implements IAccountRepository {
  @override
  Stream<Account?> accountStateChanges() {
    return FirebaseAuth.instance
        .authStateChanges()
        .map((user) => _userToAccount(user));
  }

  @override
  Future<void> savechangedEmailAddress(Account modifiedAccount) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.noCurrentUser);
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
      throw const AccountProcessException(
          AccountProcessExceptionDetail.noCurrentUser);
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
  Account? findByEmailAddress(EmailAddress emailAddress) => null;

  @override
  Account? getCurrentAccount() {
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
    required Account account,
    required Password newPassword,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.noCurrentUser);
    }
    try {
      await currentUser.updatePassword(newPassword.value);
    } on FirebaseAuthException catch (e) {
      _processFirebaseAuthException(e);
    } catch (e) {
      throw UnknownException(UnknownExceptionDetail.unknown, info: e);
    }
  }

  Account? _userToAccount(final User? user) {
    if (user == null) {
      return null;
    }
    if (user.email == null) {
      return null;
    }
    final accountId = AccountId(user.uid);
    final emailAddress = EmailAddress(user.email!);
    final account = Account(accountId: accountId, emailAddress: emailAddress);
    return account;
  }

  void _processFirebaseAuthException(final FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.weakPassword);
    } else if (e.code == 'email-already-in-use') {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.alreadyExists);
    } else if (e.code == 'user-not-found') {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.notFound);
    } else if (e.code == 'wrong-password') {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.wrongPassword);
    }
  }
}
