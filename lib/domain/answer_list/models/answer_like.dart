import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';

class AnswerLike {
  final int _value;

  int get value => _value;

  AnswerLike(this._value) {
    if (_value < 0) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.invalidAnswerLike);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is AnswerLike) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  bool operator >(Object other) {
    if (identical(this, other)) {
      return false;
    }
    if (other is AnswerLike) {
      return runtimeType == other.runtimeType && value > other.value;
    } else {
      return false;
    }
  }

  bool operator <(Object other) {
    if (identical(this, other)) {
      return false;
    }
    if (other is AnswerLike) {
      return runtimeType == other.runtimeType && value < other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => _value.hashCode;
}
