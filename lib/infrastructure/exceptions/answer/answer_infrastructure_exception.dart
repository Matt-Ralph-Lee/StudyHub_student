import '../../shared/infrastructure_exception.dart';
import 'answer_infrastructure_exception_detail.dart';

class AnswerInfrastructureException extends InfrastructureException {
  const AnswerInfrastructureException(
    AnswerInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
