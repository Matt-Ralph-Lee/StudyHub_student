import '../exception/student_domain_exception.dart';
import '../exception/student_domain_exception_detail.dart';

class QuestionCount {
  final int _value;

  int get value => _value;

  QuestionCount(this._value) {
    if (_value < 0) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidQuestionCount);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is QuestionCount) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  bool operator >(Object other) {
    if (identical(this, other)) {
      return false;
    }
    if (other is QuestionCount) {
      return runtimeType == other.runtimeType && value > other.value;
    } else {
      return false;
    }
  }

  bool operator <(Object other) {
    return !(this > other) && !(this == other);
  }

  @override
  int get hashCode => value.hashCode;
}
