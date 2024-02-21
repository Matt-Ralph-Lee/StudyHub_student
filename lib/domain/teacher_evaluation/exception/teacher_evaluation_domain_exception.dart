import '../../shared/domain_exception.dart';
import 'teacher_evaluation_domain_exception_detail.dart';

class EvaluationDomainException extends DomainException {
  const EvaluationDomainException(
    TeacherEvaluationDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
