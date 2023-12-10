import '../../shared/exception/use_case_exception.dart';
import 'student_use_case_exception_detail.dart';

class StudentUseCaseException extends UseCaseException {
  const StudentUseCaseException(
    StudentUseCaseExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
