import '../exception/teacher_evaluation_domain_exception.dart';

import '../exception/teacher_evaluation_domain_exception_detail.dart';

class TeacherEvaluationRating {
  static const minValue = 1;
  static const maxValue = 5;
  final int _value;

  int get value => _value;

  TeacherEvaluationRating(this._value) {
    if (_value < minValue || _value > maxValue) {
      throw const EvaluationDomainException(
          TeacherEvaluationDomainExceptionDetail.invalidRatingValue);
    }
  }
}
