import '../exception/evaluation_domain_exception.dart';
import '../exception/evaluation_domain_exception_detail.dart';

class EvaluationComment {
  static const minLength = 10;
  static const maxLength = 200;
  final String _value;

  EvaluationComment(this._value) {
    if (_value.length < minLength || _value.length > maxLength) {
      throw const EvaluationDomainException(
          EvaluationDomainExceptionDetail.invalidCommentLength);
    }
  }
}
