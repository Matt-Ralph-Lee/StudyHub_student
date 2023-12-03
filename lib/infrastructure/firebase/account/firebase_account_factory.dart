import 'package:uuid/uuid.dart';

import '../../../domain/account/models/account_id.dart';
import '../../../domain/account/models/account.dart';
import '../../../domain/account/models/email_address.dart';
import '../../../domain/account/models/i_account_factory.dart';
import '../../../domain/account/models/password.dart';
import 'firebase_account_repository.dart';

class FirebaseAccountFactory implements IAccountFactory {
  final FirebaseAccountRepository _repository;

  FirebaseAccountFactory(this._repository);

  @override
  Account createWithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  }) {
    var accountId = AccountId(const Uuid().v4());
    while (_repository.findById(accountId) != null) {
      accountId = AccountId(const Uuid().v4());
    }

    return Account(
      accountId: accountId,
      emailAddress: emailAddress,
      password: password,
    );
  }
}
