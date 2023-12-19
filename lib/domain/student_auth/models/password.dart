import '../exception/student_auth_domain_exception.dart';
import '../exception/student_auth_domain_exception_detail.dart';

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is Password) {
      return runtimeType == other.runtimeType && _value == other._value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => _value.hashCode;
}
