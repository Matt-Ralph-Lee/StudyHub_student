import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../exceptions/student_auth/student_auth_infrastructure_exception.dart';
import '../../exceptions/student_auth/student_auth_infrastructure_exception_detail.dart';

class FirebaseStudentAuthRepository implements IStudentAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final db = FirebaseFirestore.instance;

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
      await user.sendEmailVerification();
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

  @override
  Future<void> registerToken({
    required final EmailAddress? emailAddress,
    required final StudentId? studentId,
  }) async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();

    if (studentId != null) {
      final docRef = db.collection("students").doc(studentId.value);
      docRef.update({"fcmToken": token});
      return;
    }

    if (emailAddress != null) {
      final snapshot = await db
          .collection("students")
          .where("email", isEqualTo: emailAddress.value)
          .get();
      final docRef = snapshot.docs[0].reference;

      docRef.update({"fcmToken": token});
    }
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
    case 'auth/invalid-email':
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
    case 'auth/user-not-found':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.studentNotFound);
    case 'user-disabled':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.studentDisabled);
    case 'wrong-password':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.wrongPassword);
    case 'invalid-credential':
      throw const StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.invalidCredential);
    default:
      throw StudentAuthInfrastructureException(
          StudentAuthInfrastructureExceptionDetail.unexpected,
          info: e.code);
  }
}
