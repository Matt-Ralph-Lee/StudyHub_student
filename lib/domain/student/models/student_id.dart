import '../../shared/id.dart';
import '../exception/student_domain_exception.dart';
import '../exception/student_domain_exception_detail.dart';

class StudentId extends Id {
  final String _value;
  static const minLength = 20;

  @override
  String get value => _value;

  StudentId(this._value) : super(_value);

  @override
  void validate(final String value) {
    if (_value.length < minLength) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.idInvalidLength);
    }
  }
}
