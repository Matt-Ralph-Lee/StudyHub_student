import '../../../common/exception/student_auth/student_auth_creation_exception.dart';
import '../../../common/exception/student_auth/student_auth_creation_exception_detail.dart';

class EmailAddress {
  final _emailAddressRegExp =
      RegExp(r'^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$');
  final String _value;

  String get value => _value;

  EmailAddress(this._value) {
    _validate(_value);
  }

  void _validate(final String value) {
    if (value.isEmpty) {
      throw const StudentAuthCreationException(
          StudentAuthCreationExceptionDetail.empty);
    }
    if (!_emailAddressRegExp.hasMatch(value)) {
      throw const StudentAuthCreationException(
          StudentAuthCreationExceptionDetail.invalidEmailFormat);
    }
  }
}
