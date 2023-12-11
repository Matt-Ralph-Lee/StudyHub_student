import '../exception/student_auth_domain_exception.dart';
import '../exception/student_auth_domain_exception_detail.dart';

class EmailAddress {
  final _emailAddressRegExp =
      RegExp(r'^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$');
  final String _value;

  String get value => _value;

  EmailAddress(this._value) {
    if (!_emailAddressRegExp.hasMatch(_value)) {
      final numOfAts = RegExp(r'@').allMatches(_value).length;
      if (numOfAts != 1) {
        throw const StudentAuthDomainException(
            StudentAuthDomainExceptionDetail.invalidEmailFormat,
            info: '@');
      }
      if (!_value.contains('.')) {
        throw const StudentAuthDomainException(
            StudentAuthDomainExceptionDetail.invalidEmailFormat,
            info: '.');
      }
    }
  }
}
