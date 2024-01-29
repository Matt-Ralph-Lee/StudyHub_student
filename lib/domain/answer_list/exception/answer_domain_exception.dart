import '../../shared/domain_exception.dart';
import 'answer_domain_exception_detail.dart';

class AnswerDomainException extends DomainException {
  const AnswerDomainException(
    AnswerDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
