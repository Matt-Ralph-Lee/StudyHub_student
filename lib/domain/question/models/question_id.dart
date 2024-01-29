import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

class QuestionId {
  final String _value;
  static const minLength = 10;

  String get value => _value;

  QuestionId(this._value) {
    if (_value.length < minLength) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.idInvalidLength);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is QuestionId) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
