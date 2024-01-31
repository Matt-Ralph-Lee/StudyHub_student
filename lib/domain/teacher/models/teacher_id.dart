import '../exception/teacher_domain_exception.dart';
import '../exception/teacher_domain_exception_detail.dart';

class TeacherId {
  final String _value;
  static const minLength = 20;

  String get value => _value;

  TeacherId(this._value) {
    if (_value.length < minLength) {
      throw const TeacherDomainException(
          TeacherDomainExceptionDetail.invalidIdLength);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is TeacherId) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
