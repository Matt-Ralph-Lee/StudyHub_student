import '../../shared/domain_exception.dart';
import 'teacher_evaluation_domain_exception_detail.dart';

class TeacherEvaluationDomainException extends DomainException {
  const TeacherEvaluationDomainException(
    TeacherEvaluationDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
