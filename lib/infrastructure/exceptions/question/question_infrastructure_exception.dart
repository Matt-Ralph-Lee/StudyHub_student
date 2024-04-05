import '../../shared/infrastructure_exception.dart';
import 'question_infrastructure_exception_detail.dart';

class QuestionInfrastructureException extends InfrastructureException {
  const QuestionInfrastructureException(
    QuestionInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
