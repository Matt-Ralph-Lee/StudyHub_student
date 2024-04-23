import '../../shared/id.dart';
import '../exception/teacher_evaluation_domain_exception.dart';
import '../exception/teacher_evaluation_domain_exception_detail.dart';

class TeacherEvaluationId extends Id {
  final String _value;
  static const minLength = 20;

  @override
  String get value => _value;

  TeacherEvaluationId(this._value) : super(_value);

  @override
  void validate(String value) {
    if (_value.length < minLength) {
      throw const TeacherEvaluationDomainException(
          TeacherEvaluationDomainExceptionDetail.invalidId);
    }
  }
}
