import '../../../common/exception/account_exception/account_creation_exception.dart';
import '../../../common/exception/account_exception/account_creation_exception_detail.dart';

class Password {
  final String _value;
  static const _minLength = 6;

  String get value => _value;

  Password(final String value) : _value = value {
    if (value.isEmpty) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.empty);
    }

    _validate(_value);
  }

  void _validate(final String value) {
    if (value.length < _minLength) {
      throw const AccountCreationException(
        AccountCreationExceptionDetail.weakPassword,
        info: _minLength,
      );
    }
  }
}
