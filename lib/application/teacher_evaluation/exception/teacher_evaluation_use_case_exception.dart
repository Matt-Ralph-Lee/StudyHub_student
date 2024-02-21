import '../../shared/exception/use_case_exception.dart';
import 'teacher_evaluation_use_case_exception_detail.dart';

class EvaluationUseCaseException extends UseCaseException {
  const EvaluationUseCaseException(
    EvaluationUseCaseExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
