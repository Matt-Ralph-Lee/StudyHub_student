import '../exception/student_domain_exception.dart';
import '../exception/student_domain_exception_detail.dart';

class StudentName {
  final String _value;
  static const int minLength = 1;
  static const int maxLength = 15;

  StudentName(this._value) {
    if (_value.length < minLength) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.nameInvalidLength);
    }
    if (_value.length > maxLength) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.nameInvalidLength);
    }
  }
}
