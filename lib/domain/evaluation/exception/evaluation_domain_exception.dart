import '../../shared/domain_exception.dart';
import 'evaluation_domain_exception_detail.dart';

class EvaluationDomainException extends DomainException {
  const EvaluationDomainException(
    EvaluationDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
