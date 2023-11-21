import '../../../common/exception/argument_exception/argument_exception.dart';
import '../../../common/exception/argument_exception/argument_exception_detail.dart';
import '../../../common/exception/password_exception/password_exception.dart';
import '../../../common/exception/password_exception/password_exception_detail.dart';

class Password {
  final String _value;
  static const _minLength = 6;

  String get value => _value;

  Password(final String value) : _value = value {
    if (value.isEmpty) {
      throw const ArgumentException(ArgumentExceptionDetail.emptyException);
    }

    _validate(_value);
  }

  void _validate(final String value) {
    if (value.length < _minLength) {
      throw const PasswordException(
        PasswordExceptionDetail.shortException,
        info: _minLength,
      );
    }
  }
}
