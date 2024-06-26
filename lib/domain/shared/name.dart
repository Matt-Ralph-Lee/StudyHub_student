import '../student/exception/student_domain_exception.dart';
import '../student/exception/student_domain_exception_detail.dart';

class Name {
  final String _value;
  String get value => _value;
  static const int minLength = 1;
  static const int maxLength = 15;

  Name(this._value) {
    if (_value.length < minLength) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.nameInvalidLength);
    }
    if (_value.length > maxLength) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.nameInvalidLength);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is Name) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
