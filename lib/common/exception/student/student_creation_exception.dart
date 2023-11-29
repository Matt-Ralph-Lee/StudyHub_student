import '../generic_exception.dart';
import 'student_creation_exception_detail.dart';

class StudentCreationException extends GenericException {
  const StudentCreationException(
    StudentCreationExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
