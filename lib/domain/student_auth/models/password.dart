import '../../../common/exception/student_auth/student_auth_creation_exception.dart';
import '../../../common/exception/student_auth/student_auth_creation_exception_detail.dart';

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
      throw const StudentAuthCreationException(
          StudentAuthCreationExceptionDetail.empty);
    }
    if (value.length < _minLength) {
      throw const StudentAuthCreationException(
        StudentAuthCreationExceptionDetail.invalidLength,
        info: _minLength,
      );
    }
    if (value.length > _maxLength) {
      throw const StudentAuthCreationException(
        StudentAuthCreationExceptionDetail.invalidLength,
        info: _minLength,
      );
    }
    if (!_passwordRegExp.hasMatch(value)) {
      throw const StudentAuthCreationException(
          StudentAuthCreationExceptionDetail.invalidCharacter);
    }
  }
}
