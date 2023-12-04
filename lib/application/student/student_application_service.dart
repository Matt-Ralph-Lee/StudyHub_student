import 'package:studyhub/common/exception/student/student_creation_exception.dart';
import 'package:studyhub/common/exception/student/student_creation_exception_detail.dart';
import 'package:studyhub/common/exception/student/student_process_exception_detail.dart';
import 'package:studyhub/common/exception/student/student_process_exception.dart';
import 'package:studyhub/domain/photo/models/i_photo_factory.dart';
import 'package:studyhub/domain/student/models/i_student_repository.dart';
import 'package:studyhub/domain/student/models/email_address.dart';
import 'package:studyhub/domain/account/password.dart';
import 'package:studyhub/domain/student/services/student_domain_service.dart';

import '../../domain/photo/models/photo.dart';
import '../../infrastructure/firebase/student/firebase_student_factory.dart';

class StudentApplicationService {
  // TODO: エラー捕捉チェック
  final IAccountRepository _repository;
  final FirebaseStudentFactory _factory;
  final StudentDomainService _service;

  StudentApplicationService({
    required final IAccountRepository repository,
    required final FirebaseStudentFactory factory,
    required final StudentDomainService service,
  })  : _repository = repository,
        _factory = factory,
        _service = service;

  Future<void> register(
    final String emailAddressData,
    final String passwordData,
  ) async {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    final student = _factory.createwithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    if (_service.exists(student)) {
      throw const StudentCreationException(
          StudentCreationExceptionDetail.alreadyExists);
    }
    await _repository.save(student);
  }

  Future<void> signIn({
    required final String emailAddressData,
    required final String passwordData,
  }) async {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    await _repository.signIn(emailAddress: emailAddress, password: password);
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }

  Future<void> delete() async {
    await _repository.delete();
    // TODO: 他のリポジトリにあるデータも削除する
  }

  Future<void> resetPassword(final String newPasswordData) async {
    final newPassword = Password(newPasswordData);
    final account = _repository.getCurrentAccount();
    if (account == null) {
      throw const StudentProcessException(
          StudentProcessExceptionDetail.noCurrentStudent);
    }
    await _repository.resetPassword(account: account, newPassword: newPassword);
  }

  Future<void> changeEmailAddress(final String newemailAddressData) async {
    final newEmailAddress = EmailAddress(newemailAddressData);
    final account = _repository.getCurrentAccount();
    if (account == null) {
      throw const StudentProcessException(
          StudentProcessExceptionDetail.noCurrentStudent);
    }
    if (_service.exists(newEmailAddress)) {
      throw const StudentCreationException(
          StudentCreationExceptionDetail.alreadyExists);
    }
    account.changeEmailAddress(newEmailAddress);
    await _repository.saveChangedEmailAddress(account);
  }
}
