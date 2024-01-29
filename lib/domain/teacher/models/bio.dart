import '../exception/teacher_domain_exception.dart';
import '../exception/teacher_domain_exception_detail.dart';

class Bio {
  final String _value;
  static const maxLength = 30;

  String get value => _value;

  Bio(this._value) {
    if (_value.length > maxLength) {
      throw const TeacherDomainException(
          TeacherDomainExceptionDetail.invalidBioLength);
    }
  }
}
