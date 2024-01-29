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
}
