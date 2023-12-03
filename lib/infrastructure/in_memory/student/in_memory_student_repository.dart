import 'package:uuid/uuid.dart';

import '../../../common/exception/student/student_process_exception.dart';
import '../../../common/exception/student/student_process_exception_detail.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/account/models/account_id.dart';
import '../../../domain/student/models/email_address.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/account/password.dart';

class InMemoryStudentRepository implements IAccountRepository {
  var store = <Map?>{};

  @override
  Future<void> create({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final accountId = AccountId(const Uuid().v4());
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final Map<String, dynamic>? data = <String, dynamic>{
      'accountId': accountId.value,
      'emailAddress': emailAddress.value,
      'password': password.value,
      'isSignedIn': false,
    };
    store.add(data);
  }

  @override
  Future<void> signIn({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    var data = store.firstWhere((d) {
      if (d == null) {
        return false;
      }
      return d['emailAddress'] == emailAddress.value;
    }, orElse: () => null);

    if (data == null) {
      throw const StudentProcessException(
          StudentProcessExceptionDetail.notFound);
    }
    if (data['password'] != password.value) {
      throw const StudentProcessException(
          StudentProcessExceptionDetail.wrongPassword);
    }
    data['isSignedIn'] = true;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<Student?> accountStateChanges() {
    // TODO: implement accountStateChanges
    throw UnimplementedError();
  }

  @override
  Student? findByEmailAddress(EmailAddress emailAddress) {
    // TODO: implement findByEmailAddress
    throw UnimplementedError();
  }

  @override
  Stream<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<void> saveChangedEmailAddress(Student modifiedAccount) {
    // TODO: implement changeEmailAddress
    throw UnimplementedError();
  }

  @override
  Student? getCurrentAccount() {
    // TODO: implement getCurrentAccount
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(
      {required Student account, required Password newPassword}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  Student _clone(Student account) {
    return Student(
        studentId: account.accountId, emailAddress: account.emailAddress);
  }
}
