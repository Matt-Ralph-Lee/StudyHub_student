import '../generic_exception.dart';
import 'student_auth_process_exception_detail.dart';

class StudentAuthProcessException extends GenericException {
  const StudentAuthProcessException(
    StudentAuthProcessExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
