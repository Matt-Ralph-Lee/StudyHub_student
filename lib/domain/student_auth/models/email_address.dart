import '../exception/student_auth_domain_exception.dart';
import '../exception/student_auth_domain_exception_detail.dart';

class EmailAddress {
  final _emailAddressRegExp =
      RegExp(r'^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$');
  final String _value;

  String get value => _value;

  EmailAddress(this._value) {
    if (!_emailAddressRegExp.hasMatch(_value)) {
      throw const StudentAuthDomainException(
          StudentAuthDomainExceptionDetail.invalidEmailFormat);
    }
  }
}
