import '../../shared/exception/use_case_exception.dart';
import 'student_auth_use_case_exception_detail.dart';

class StudentAuthUseCaseException extends UseCaseException {
  const StudentAuthUseCaseException(
    StudentAuthUseCaseExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
