import 'package:studyhub/domain/account/models/email_address.dart';
import 'package:studyhub/domain/account/models/password.dart';

import 'account.dart';

abstract class IAccountFactory {
  Account createWithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  });
}
