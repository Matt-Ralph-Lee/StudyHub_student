import '../../../common/exception/account_exception/account_creation_exception.dart';
import '../../../common/exception/account_exception/account_creation_exception_detail.dart';

class EmailAddress {
  final _emailAddressRegExp =
      RegExp(r'^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$');
  final String _value;

  String get value => _value;

  EmailAddress(final String value) : _value = value {
    _validate(_value);
  }

  void _validate(final String value) {
    if (_value.isEmpty) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.empty);
    }
    if (!_emailAddressRegExp.hasMatch(value)) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.invalidEmailFormat);
    }
  }

  @override
  bool operator ==(final Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is EmailAddress) {
      return runtimeType == other.runtimeType && _value == other._value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => _value.hashCode;
}
