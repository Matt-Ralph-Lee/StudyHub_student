import '../../../common/exception/account/account_creation_exception.dart';
import '../../../common/exception/account/account_creation_exception_detail.dart';

class AccountId {
  final String _value;

  String get value => _value;

  AccountId(this._value) {
    if (_value.isEmpty) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.empty);
    }
  }
}
