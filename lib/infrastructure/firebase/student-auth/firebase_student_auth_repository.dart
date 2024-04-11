import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../exceptions/student_auth/student_auth_infrastructure_exception.dart';
import '../../exceptions/student_auth/student_auth_infrastructure_exception_detail.dart';

class FirebaseStudentAuthRepository implements IStudentAuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseStudentAuthRepository({required final FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<void> createWithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress.value,
        password: password.value,
      );
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } catch (e) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected);
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notSignedIn);
    }
    try {
      print("hoge");
      await user.sendEmailVerification();
      print("huga");
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } catch (e) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected);
    }
  }

  @override
  Future<void> delete() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notSignedIn);
    }
    // TODO: have to implement user.reauthenticateWithCredential ?
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } catch (e) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected);
    }
  }

  @override
  Future<void> updateEmailAddress(final EmailAddress emailAddress) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.notSignedIn);
    }
    try {
      await user.verifyBeforeUpdateEmail(emailAddress.value);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } catch (e) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(
      {required final EmailAddress emailAddress}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: emailAddress.value);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } catch (e) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected);
    }
  }

  @override
  Future<void> signIn({
    required final EmailAddress emailAddress,
    required final Password password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress.value,
        password: password.value,
      );
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } catch (e) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } catch (e) {
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected);
    }
  }

  @override
  StudentId? getStudentIdSnapshot() {
    if (_firebaseAuth.currentUser == null) return null;
    return StudentId(_firebaseAuth.currentUser!.uid);
  }

  @override
  Future<void> reloadUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    await firebaseUser?.reload();
  }
}

void _handleFirebaseAuthException(final FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.emailAddressAlreadyInUse);
    case 'invalid-email':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.invalidEmailAddress);
    case 'weak-password':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.weakPassword);
    case 'requires-recent-login':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.noRecentSignIn);
    case 'user-not-found':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.studentNotFound);
    case 'user-disabled':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.studentDisabled);
    case 'wrong-password':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.wrongPassword);
    default:
      throw StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected,
          info: e.code);
  }
}
