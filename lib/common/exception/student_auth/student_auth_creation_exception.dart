import '../generic_exception.dart';
import 'student_auth_creation_exception_detail.dart';

class StudentAuthCreationException extends GenericException {
  const StudentAuthCreationException(
    StudentAuthCreationExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
