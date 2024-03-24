import '../../shared/exception/use_case_exception.dart';
import 'answer_use_case_exception_detail.dart';

class AnswerUseCaseException extends UseCaseException {
  const AnswerUseCaseException(
    AnswerUseCaseExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
