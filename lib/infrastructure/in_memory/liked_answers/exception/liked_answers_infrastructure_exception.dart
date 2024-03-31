import '../../../shared/infrastructure_exception.dart';
import 'liked_answers_infrastructure_exception_detail.dart';

class LikedAnswersInfrastructureException extends InfrastructureException {
  const LikedAnswersInfrastructureException(
    LikedAnswersInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
