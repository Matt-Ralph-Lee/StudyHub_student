import '../exception/teacher_evaluation_domain_exception.dart';
import '../exception/teacher_evaluation_domain_exception_detail.dart';

class TeacherEvaluationComment {
  static const minLength = 10;
  static const maxLength = 200;
  final String _value;

  String get value => _value;

  TeacherEvaluationComment(this._value) {
    if (_value.length < minLength || _value.length > maxLength) {
      throw const EvaluationDomainException(
          TeacherEvaluationDomainExceptionDetail.invalidCommentLength);
    }
  }
}
