import '../../shared/exception/use_case_exception.dart';
import 'question_use_case_exception_detail.dart';

class QuestionUseCaseException extends UseCaseException {
  const QuestionUseCaseException(
    QuestionUseCaseExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
