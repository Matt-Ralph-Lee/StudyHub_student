import 'package:studyhub/common/exception/account_exception/account_process_exception.dart';
import 'package:studyhub/common/exception/account_exception/account_process_exception_detail.dart';
import 'package:studyhub/domain/account_for_student/models/account_id.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/account_for_student/models/account.dart';
import '../../../domain/account_for_student/models/email_address.dart';
import '../../../domain/account_for_student/models/i_account_repository.dart';
import '../../../domain/account_for_student/models/password.dart';

class InMemoryAccountRepository implements IAccountRepository {
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
      throw const AccountProcessException(
          AccountProcessExceptionDetail.notFound);
    }
    if (data['password'] != password.value) {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.wrongPassword);
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
  Stream<Account?> accountStateChanges() {
    // TODO: implement accountStateChanges
    throw UnimplementedError();
  }

  @override
  Account? findByEmailAddress(EmailAddress emailAddress) {
    // TODO: implement findByEmailAddress
    throw UnimplementedError();
  }

  @override
  Stream<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<void> savechangedEmailAddress(Account modifiedAccount) {
    // TODO: implement changeEmailAddress
    throw UnimplementedError();
  }

  @override
  Account? getCurrentAccount() {
    // TODO: implement getCurrentAccount
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(
      {required Account account, required Password newPassword}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  Account _clone(Account account) {
    return Account(
        accountId: account.accountId, emailAddress: account.emailAddress);
  }
}
