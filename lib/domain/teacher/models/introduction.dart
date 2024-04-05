import '../exception/teacher_domain_exception.dart';
import '../exception/teacher_domain_exception_detail.dart';

class Introduction {
  final String _value;
  static const maxLength = 250;

  Introduction(this._value) {
    if (_value.length > maxLength) {
      throw const TeacherDomainException(
          TeacherDomainExceptionDetail.invalidIntroductionLength);
    }
  }

  String get value => _value;
}
