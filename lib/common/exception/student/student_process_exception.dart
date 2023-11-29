import '../generic_exception.dart';
import 'student_process_exception_detail.dart';

class StudentProcessException extends GenericException {
  const StudentProcessException(
    StudentProcessExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
