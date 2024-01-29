import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

class QuestionText {
  final String _value;
  String get value => _value;
  static const int maxLength = 300;
  static const int maxLine = 14;

  QuestionText(this._value) {
    if (_value.isEmpty) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.textEmptyLength);
    }
    if (_value.length > maxLength) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.textInvalidLength);
    }
    if (_value.split('\n').length > maxLine) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.textInvalidLineLength);
    }
  }
}
