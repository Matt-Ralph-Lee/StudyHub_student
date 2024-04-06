import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';

class AnswerText {
  final String _value;
  String get value => _value;
  static const int maxLength = 2000;

  AnswerText(this._value) {
    if (_value.isEmpty) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.textEmptyLength);
    }
    if (_value.length > maxLength) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.textInvalidLength);
    }
  }
}
