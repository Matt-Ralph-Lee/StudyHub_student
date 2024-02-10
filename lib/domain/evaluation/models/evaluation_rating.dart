import '../exception/evaluation_domain_exception.dart';

import '../exception/evaluation_domain_exception_detail.dart';

class EvaluationRating {
  static const minValue = 1;
  static const maxValue = 5;
  final int _value;

  EvaluationRating(this._value) {
    if (_value < minValue || _value > maxValue) {
      throw const EvaluationDomainException(
          EvaluationDomainExceptionDetail.invalidRatingValue);
    }
  }
}
