import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

class QuestionTitle {
  final String _value;
  String get value => _value;
  static const int minLength = 1;
  static const int maxLength = 15;

  QuestionTitle(this._value) {
    if (_value.length < minLength) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.titleInvalidLength);
    }
    if (_value.length > maxLength) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.titleInvalidLength);
    }
  }
}
