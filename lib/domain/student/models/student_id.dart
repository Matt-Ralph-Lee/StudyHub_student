import '../exception/student_domain_exception.dart';
import '../exception/student_domain_exception_detail.dart';

class StudentId {
  final String _value;
  static const minLength = 20;

  String get value => _value;

  StudentId(this._value) {
    if (_value.length < minLength) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.idInvalidLength);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is StudentId) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
