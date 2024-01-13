import '../../../shared/infrastructure_exception.dart';
import 'student_auth_infrastructure_exception_detail.dart';

class StudentAuthInfrastructureException extends InfrastructureException {
  const StudentAuthInfrastructureException(
    StudentAuthInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
