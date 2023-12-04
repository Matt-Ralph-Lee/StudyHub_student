import '../../../common/exception/account/account_creation_exception.dart';
import '../../../common/exception/account/account_creation_exception_detail.dart';

final blurredPassword = Password('blurred');

class Password {
  final _passwordRegExp = RegExp(r'^[a-zA-Z0-9!@#$%^&*()_+-=?<>/.,;:{}|]+$');
  final String _value;
  static const _minLength = 6;
  static const _maxLength = 64;

  Password(this._value) {
    _validate(_value);
  }

  void _validate(final String value) {
    if (value.isEmpty) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.empty);
    }
    if (value.length < _minLength) {
      throw const AccountCreationException(
        AccountCreationExceptionDetail.invalidLength,
        info: _minLength,
      );
    }
    if (value.length > _maxLength) {
      throw const AccountCreationException(
        AccountCreationExceptionDetail.invalidLength,
        info: _minLength,
      );
    }
    if (!_passwordRegExp.hasMatch(value)) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.invalidCharacter);
    }
  }
}
