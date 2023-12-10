import '../exception/student_auth_domain_exception.dart';
import '../exception/student_auth_domain_exception_detail.dart';

final blurredPassword = Password('blurred');

class Password {
  final _passwordRegExp = RegExp(r'^[a-zA-Z0-9!@#$%^&*()_+-=?<>/.,;:{}|]+$');
  final String _value;
  static const minLength = 6;
  static const maxLength = 64;

  Password(this._value) {
    _validate(_value);
  }

  void _validate(final String value) {
    if (!_passwordRegExp.hasMatch(value)) {
      throw const StudentAuthDomainException(
          StudentAuthDomainExceptionDetail.invalidCharacter);
    }
    if (value.length < minLength) {
      throw const StudentAuthDomainException(
          StudentAuthDomainExceptionDetail.shortPassword);
    }
    if (value.length > maxLength) {
      throw const StudentAuthDomainException(
          StudentAuthDomainExceptionDetail.longPassword);
    }
  }
}
