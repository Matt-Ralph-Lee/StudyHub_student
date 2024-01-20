import '../../shared/domain_exception.dart';
import 'question_domain_exception_detail.dart';

class QuestionDomainException extends DomainException {
  const QuestionDomainException(
    QuestionDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
